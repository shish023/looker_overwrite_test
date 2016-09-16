- view: bp_brand_in_progress
  derived_table:
    sql: |
      SELECT * from pgadmin.metrics m 
      LEFT JOIN pgadmin.brands b
      ON m.key::int = b.id
      WHERE m.metric = 11

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
    
  - dimension: parent_brand_id
    primary_key: true
    type: number
    sql: ${TABLE}.parent_brand_id

  - dimension: brand_key
    type: string
    sql: ${TABLE}.brand_key

  - dimension: brand_name
    type: string
    sql: ${TABLE}.brand_name

  - dimension: category
    type: string
    sql: ${TABLE}.category

  - dimension: coexist
    type: yesno
    sql: ${TABLE}.coexist

  - dimension: countries
    type: string
    sql: ${TABLE}.countries

  - dimension: dedup_distance
    type: number
    sql: ${TABLE}.dedup_distance

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

  - dimension: location_type
    type: number
    sql: ${TABLE}.location_type

  - dimension: override_near_by_radius_in_miles
    type: number
    sql: ${TABLE}.override_near_by_radius_in_miles

  - dimension: override_wider_reach_radius_in_miles
    type: number
    sql: ${TABLE}.override_wider_reach_radius_in_miles

  - dimension: parent_name
    type: string
    sql: ${TABLE}.parent_name

  - dimension_group: updated
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updated_date

  - dimension: url_logo
    type: string
    sql: ${TABLE}.url_logo

  - dimension: whitelist
    type: number
    sql: ${TABLE}.whitelist

  - measure: brand_in_progress_count
    label: "Brand In Progress Count"
    type: count_distinct
    sql: ${key}


