- view: velocity_country

  derived_table:
    sql: |
        select 
        country,
        date,
        value,
        CASE WHEN country = lag(country,1) over (order by country,date) then value - lag(value,1) over (order by country,date)
        ELSE NULL
        END as value_diff,
        CASE WHEN country = lag(country,1) over (order by country,date) then date - lag(date,1) over (order by country,date)
        ELSE NULL
        END as date_diff
        from (select country, date, sum(value) as value from pgadmin.metrics where metric = 4 group by 1,2 order by 1,2) t
        
  fields:

  - dimension: country
    type: string
    sql: ${TABLE}.country

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
    type: number
    primary_key: true
    sql: ${TABLE}.country || ${TABLE}.date
    
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


