- view: bp_category_attempted
  derived_table:
    sql: |
      SELECT substring(m.key from 0 for 7), * from pgadmin.metrics m 
      LEFT JOIN pgadmin.categories c
      ON substring(m.key from 0 for 7) = c.sic_code
      WHERE m.metric = 18

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
    
  - dimension: parent_category_id
    primary_key: true
    type: number
    sql: ${TABLE}.parent_category_id

  - dimension: block_type
    type: number
    sql: ${TABLE}.block_type

  - dimension: brand_key
    type: string
    sql: ${TABLE}.brand_key

  - dimension: category_name
    type: string
    sql: ${TABLE}.category_name

  - dimension: category_type
    type: string
    sql: ${TABLE}.category_type

  - dimension: clustering_eps
    type: number
    sql: ${TABLE}.clustering_eps

  - dimension: clustering_tag
    type: number
    sql: ${TABLE}.clustering_tag

  - dimension: coexist
    type: yesno
    sql: ${TABLE}.coexist

  - dimension: countries
    type: string
    sql: ${TABLE}.countries

  - dimension: domain
    type: string
    sql: ${TABLE}.domain

  - dimension: fence_size
    type: string
    sql: ${TABLE}.fence_size

  - dimension: hide
    type: yesno
    sql: ${TABLE}.hide

  - dimension: id
    type: number
    sql: ${TABLE}.id

  - dimension: max_area
    type: number
    sql: ${TABLE}.max_area

  - dimension: min_area
    type: number
    sql: ${TABLE}.min_area

  - dimension: not_indexed
    type: yesno
    sql: ${TABLE}.not_indexed

  - dimension: parent_name
    type: string
    sql: ${TABLE}.parent_name

  - dimension: sic_code
    type: string
    sql: ${TABLE}.sic_code

  - dimension: small_business_eligible
    type: yesno
    sql: ${TABLE}.small_business_eligible

  - dimension_group: updated
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updated_date

  - dimension: whitelist
    type: number
    sql: ${TABLE}.whitelist