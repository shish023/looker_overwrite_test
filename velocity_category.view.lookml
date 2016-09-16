- view: velocity_category

  derived_table:
    sql: |
        select
        category_name, 
        key as category_code,
        date,
        value,
        CASE WHEN key = lag(key,1) over (order by key,date) then value - lag(value,1) over (order by key,date)
        ELSE NULL
        END as value_diff,
        CASE WHEN key = lag(key,1) over (order by key,date) then date - lag(date,1) over (order by key,date)
        ELSE NULL
        END as date_diff
        from (select key, date, sum(value) as value from pgadmin.metrics where metric = 12 group by 1,2 order by 1,2) t
        join pgadmin.categories
        on substring(key from 0 for 7) = categories.sic_code
        
  fields:

  - dimension: category_name
    type: string
    sql: ${TABLE}.category_name
    
  - dimension: category_code
    type: string
    sql: ${TABLE}.category_code

  - dimension_group: date
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.date

  - dimension: value
    type: number
    sql: ${TABLE}.value
    
  - dimension: value_diff
    type: number
    sql: ${TABLE}.value_diff
    
  - dimension: date_diff
    type: number
    sql: ${TABLE}.date_diff
    
  - dimension: primary
    type: string
    primary_key: true
    sql: (${TABLE}.category_code::text || ${TABLE}.category_name::text || ${TABLE}.date::text)
    
  - measure: value_sum
    type: sum
    sql: ${value_diff}
    
  - measure: date_sum
    type: avg
    sql: ${date_diff}
    
  - measure: velocity
    type: number
    sql: ${value_sum} / NULLIF(${date_sum}, 0)
    value_format_name: decimal_2


