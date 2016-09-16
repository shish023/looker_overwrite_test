- view: poi_country
  derived_table:
    sql: |
      SELECT * FROM pgadmin.metrics m WHERE m.metric = 1

  fields:

  - dimension: country
    type: string
    sql: ${TABLE}.country

  - dimension_group: date
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.date

  - dimension: key
    type: string
    sql: ${TABLE}.key

  - dimension: metric
    type: number
    sql: ${TABLE}.metric

  - dimension: value
    type: number
    sql: ${TABLE}.value
    
  - measure: poi_count
    label: "POI Count"
    type: sum
    sql: ${value}
