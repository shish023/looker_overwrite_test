- view: top_categories
  derived_table:
    sql: |
        select metric, category_name, substring(key from 0 for 7) as category , sum(value) as approved, rank () over ( order by sum(value) desc) 
        from (select * from pgadmin.metrics join pgadmin.categories on substring(metrics.key from 0 for 7) = categories.sic_code where metric = 12) a
        where metric = 12 
        and date = (SELECT date from (SELECT country, max(date) as date from pgadmin.metrics where {% condition date %} ${metrics.date} {% endcondition %} group by country) max_date_table group by date) 
        group by 1,2,3
        
  fields:

  - dimension: category
    type: string
    sql: ${TABLE}.category
    
  - dimension: category_name
    type: string
    sql: ${TABLE}.category_name

  - dimension: metric
    type: number
    sql: ${TABLE}.metric

  - dimension: approved
    type: number
    sql: ${TABLE}.approved
    
  - dimension: category_rank
    type: string
    sql: ${TABLE}.rank

  - measure: min_rank
    type: min
    sql: ${category_rank}
    hidden: true
    
  - dimension: is_top_10
    label: "Is Top 10?"
    type: yesno
    sql: ${TABLE}.rank < 10
    
  - dimension: top_10_categories
    sql: CASE WHEN ${is_top_10} = 'Yes' then ${category} else '-1' end
    order_by_field: min_rank
    
  - dimension: top_10_category_names
    sql: CASE WHEN ${is_top_10} = 'Yes' then ${category_name} else 'Other' end
    order_by_field: min_rank
      
  - measure: total_approved
    label: "Total Approved"
    type: sum
    sql: ${approved}
    
  - filter: date
    type: date
    
  

