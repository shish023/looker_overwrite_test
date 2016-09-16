- view: top_brands
  derived_table:
    sql: |
        select metric, brand_name, id , sum(value) as approved, rank () over ( order by sum(value) desc) 
        from (select * from pgadmin.metrics join pgadmin.brands on metrics.key::int = brands.id where metric = 4) a
        where metric = 4
        and date = (SELECT date from (SELECT country, max(date) as date from pgadmin.metrics where date='2016-09-01' group by country) max_date_table group by date) 
        group by 1,2,3
        
  fields:

  - dimension: brand_id
    type: string
    sql: ${TABLE}.id
    
  - dimension: brand_name
    type: string
    sql: ${TABLE}.brand_name

  - dimension: metric
    type: number
    sql: ${TABLE}.metric

  - dimension: approved
    type: number
    sql: ${TABLE}.approved
    
  - dimension: brand_rank
    type: string
    sql: ${TABLE}.rank

  - measure: min_rank
    type: min
    sql: ${brand_rank}
    hidden: true
    
  - dimension: is_top_10
    label: "Is Top 10?"
    type: yesno
    sql: ${TABLE}.rank < 20
    
  - dimension: top_10_brand_ids
    sql: CASE WHEN ${is_top_10} = 'Yes' then ${brand_id} else -1 end
    order_by_field: min_rank
    
  - dimension: top_10_brand_names
    sql: CASE WHEN ${is_top_10} = 'Yes' then ${brand_name} else 'Other' end
    order_by_field: min_rank
      
  - measure: total_approved
    label: "Total Approved"
    type: sum
    sql: ${approved}
    
  - filter: date
    type: date
    
  

