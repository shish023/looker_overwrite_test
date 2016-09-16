- view: top_countries

  derived_table:
    sql: |
        select country, metric, sum(value) as approved, rank () over ( order by sum(value) desc) from pgadmin.metrics where metric = 4 and date = (SELECT date from (SELECT country, max(date) as date from pgadmin.metrics where {% condition date %} ${metrics.date} {% endcondition %} group by country) max_date_table group by date) group by 1,2
        
        
  fields:

  - dimension: country
    type: string
    sql: ${TABLE}.country

  - dimension: key
    type: string
    sql: |
      CASE WHEN ${TABLE}.key = '' THEN '-1'
      ELSE ${TABLE}.key
      END

  - dimension: metric
    type: number
    sql: ${TABLE}.metric

  - dimension: approved
    type: number
    sql: ${TABLE}.approved
    
  - dimension: country_rank
    type: string
    sql: ${TABLE}.rank

  - measure: min_rank
    type: min
    sql: ${country_rank}
    hidden: true
    
  - dimension: is_top_10
    label: "Is Top 10?"
    type: yesno
    sql: ${TABLE}.rank < 10
    
  - dimension: top_10_countries
    sql: CASE WHEN ${is_top_10} = 'Yes' then ${country} else 'Other' end
    order_by_field: min_rank
      
  - measure: total_approved
    label: "Total Approved"
    type: sum
    sql: ${approved}
    
  - filter: date
    type: date
    
  
