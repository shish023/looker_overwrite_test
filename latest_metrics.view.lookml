- view: latest_metrics

  derived_table:
    sql: |
        SELECT * from pgadmin.metrics
        WHERE date = (SELECT date from (SELECT country, max(date) as date from pgadmin.metrics where {% condition date %} ${metrics.date} {% endcondition %} group by country) max_date_table group by date)

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
    sql: |
      CASE WHEN ${TABLE}.key = '' THEN '-1'
      ELSE ${TABLE}.key
      END

  - dimension: metric
    type: number
    sql: ${TABLE}.metric

  - dimension: value
    type: number
    sql: ${TABLE}.value

  - measure: count
    type: count
    drill_fields: []
    
  - measure: total_poi_country
    label: "Total POI Count by Country"
    type: sum
    sql: ${value}
    filters:
      latest_metrics.metric: "1"
      
  - measure: total_poi_brand
    label: "Total POI Count by Brand"
    type: sum
    sql: ${value}
    filters:
      latest_metrics.metric: "2"
      
  - measure: total_poi_category
    label: "Total POI Count by Category"
    type: sum
    sql: ${value}
    filters:
      latest_metrics.metric: "3"
      
  - measure: total_approved_count_brand
    label: "Total Approved Count By Brand"
    type: sum
    sql: ${value}
    filters:
      latest_metrics.metric: "4"
    
  - measure: total_rejected_count_brand
    label: "Total Rejected Count By Brand"
    type: sum
    sql: ${value}
    filters:
      latest_metrics.metric: "5"
    
  - measure: total_need_review_count_brand
    label: "Total Need Review Count By Brand"
    type: sum
    sql: ${value}
    filters:
      latest_metrics.metric: "6"
      
  - measure: total_need_approval_count_brand
    label: "Total Need Approval Count By Brand"
    type: sum
    sql: ${value}
    filters:
      latest_metrics.metric: "7"
      
  - measure: total_need_curation_count_brand
    label: "Total Need Curation Count By Brand"
    type: sum
    sql: ${value}
    filters:
      latest_metrics.metric: "8"
      
  - measure: total_new_count_brand
    label: "Total New Count By Brand"
    type: sum
    sql: ${value}
    filters:
      latest_metrics.metric: "9"
      
  - measure: total_attempted_count_brand
    label: "Total Attempted Count By Brand"
    type: sum
    sql: ${value}
    filters:
      latest_metrics.metric: "10"
      
  - measure: total_in_progress_count_brand
    label: "Total In Progress Count By Brand"
    type: sum
    sql: ${value}
    filters:
      latest_metrics.metric: "11"
    
  # reconfirm how total no of brands should be computed
  - measure: brand_count
    label: "Brand Count"
    type: count_distinct
    sql: ${key}
    filters:
      latest_metrics.metric: "2"
      
  - measure: brand_completed_count
    label: "Brand Completed Count"
    type: count
    sql: ${key}
    filters:
      latest_metrics.metric: "4"
      
  - measure: brand_in_progress_count
    label: "Brand In Progress Count"
    type: count
    sql: ${key}
    filters:
      latest_metrics.metric: "11"
      
  
  
  
  - measure: total_bp_count_brand
    label: "Total BP'ed Count By Brand"
    type: number
    sql: ${total_approved_count_brand} + ${total_rejected_count_brand} + ${total_need_review_count_brand}
    
#   - measure: total_in_progress_count
#     label: "Total In Progress Count"
#     type: number
#     sql: ${total_need_approval_count} + ${total_need_curation_count} + ${total_new_count}
    
  - measure: total_bp_percentage_brand
    label: "% Completed By Brand"
    type: number
    sql: ${total_bp_count_brand} / NULLIF(( ${total_bp_count_brand} + ${total_in_progress_count_brand} ), 0)
    value_format_name: percent_2
    
  - measure: total_rejected_percentage_brand
    label: "% Rejected By Brand"
    type: number
    sql: ${total_rejected_count_brand} / NULLIF(( ${total_bp_count_brand} + ${total_in_progress_count_brand} ), 0)
    value_format_name: percent_2
    
    
    
    
  

  - measure: total_approved_count_category
    label: "Total Approved Count By Category"
    type: sum
    sql: ${value}
    filters:
      latest_metrics.metric: "12"
   
  - measure: total_rejected_count_category
    label: "Total Rejected Count By Category"
    type: sum
    sql: ${value}
    filters:
      latest_metrics.metric: "13"
    
  - measure: total_need_review_count_category
    label: "Total Need Review Count By Category"
    type: sum
    sql: ${value}
    filters:
      latest_metrics.metric: "14"
      
  - measure: total_need_approval_count_category
    label: "Total Need Approval Count By Category"
    type: sum
    sql: ${value}
    filters:
      latest_metrics.metric: "15"
      
  - measure: total_need_curation_count_category
    label: "Total Need Curation Count By Category"
    type: sum
    sql: ${value}
    filters:
      latest_metrics.metric: "16"
      
  - measure: total_new_count_category
    label: "Total New Count By Category"
    type: sum
    sql: ${value}
    filters:
      latest_metrics.metric: "17"
      
  - measure: total_attempted_count_category
    label: "Total Attempted Count By Category"
    type: sum
    sql: ${value}
    filters:
      latest_metrics.metric: "18"
      
  - measure: total_in_progress_count_category
    label: "Total In Progress Count By Category"
    type: sum
    sql: ${value}
    filters:
      latest_metrics.metric: "19"
      
      
  
  
  
  - measure: total_bp_count_category
    label: "Total BP'ed Count By Category"
    type: number
    sql: ${total_approved_count_category} + ${total_rejected_count_category} + ${total_need_review_count_category}
    
#   - measure: total_in_progress_count
#     label: "Total In Progress Count"
#     type: number
#     sql: ${total_need_approval_count} + ${total_need_curation_count} + ${total_new_count}
    
  - measure: total_bp_percentage_category
    label: "% Completed By Category"
    type: number
    sql: ${total_bp_count_category} / NULLIF(( ${total_bp_count_category} + ${total_in_progress_count_category} ), 0)
    value_format_name: percent_2
    
  - measure: most_recent_date
    type: date
    sql: MAX(${date_date})
    
  - filter: date
    type: date
    

