- view: brands
  sql_table_name: pgadmin.brands
  fields:

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

  - measure: count
    type: count
    drill_fields: detail*


  # ----- Sets of fields for drilling ------
  sets:
    detail:
    - parent_brand_id
    - brand_name
    - parent_name
    - brand_patterns.count
    - dataaxle_chain_brand_mapping.count
    - dataaxle_normed.count
    - hash_map.count
    - im_poi_store_2014_12_05.count
    - im_poi_store_2015_04_23.count
    - im_poi_store_2015_10_07.count
    - im_polygon_store_2014_12_05.count
    - im_polygon_store_2015_04_23.count
    - im_polygon_store_2015_10_07.count
    - infousa_normed.count
    - marketlocation_normed.count
    - osm_nodeonly_2014_12_05.count
    - osm_nodeonly_2015_04_23.count
    - osm_nodeonly_2015_10_07.count
    - poi_backup_china.count
    - poi_old.count
    - poiplaza_normed.count
    - poi_shopping_backup.count
    - vendor_poi_insertion_temp.count
    - xad_normed.count

