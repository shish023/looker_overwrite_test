- connection: poi_db

- include: "*.view.lookml"       # include all views in this project
- include: "*.dashboard.lookml"  # include all dashboards in this project

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# - explore: order_items
#   joins:
#     - join: orders
#       sql_on: ${orders.id} = ${order_items.order_id}
#     - join: users
#       sql_on: ${users.id} = ${orders.user_id}

- explore: metrics
#   sql_always_where: ${metrics.date_date} = ${metrics.new_date}
  joins:
    - join: brands
      sql_on: ${metrics.key}::int = ${brands.id} and ${metrics.metric} between 4 and 11
      type: left_outer
      relationship: many_to_one
      
    - join: categories
      sql_on: substring(${metrics.key} from 0 for 7) = ${categories.sic_code} and ${metrics.metric} between 12 and 19
      type: left_outer
      relationship: many_to_one
      
    - join: top_countries
      sql_on: ${metrics.country} = ${top_countries.top_10_countries}
      type: left_outer
      relationship: many_to_one
      
    - join: top_categories
      sql_on: substring(${metrics.key} from 0 for 7) = ${top_categories.top_10_categories}
      type: left_outer
      relationship: many_to_one
      
    - join: top_brands
      sql_on: ${metrics.key}::int = ${top_brands.top_10_brand_ids}
      type: left_outer
      relationship: many_to_one
      
    - join: velocity_country
      sql_on: ${metrics.date_date} = ${velocity_country.date_date} and ${metrics.country} = ${velocity_country.country}
      type: left_outer
      relationship: many_to_one
      
    - join: velocity_category
      sql_on: ${metrics.date_date} = ${velocity_category.date_date} and substring(${metrics.key} from 0 for 7) = substring(${velocity_category.category_code} from 0 for 7)
      type: left_outer
      relationship: many_to_one
      
- explore: latest_metrics
#   sql_always_where: ${metrics.date_date} = ${metrics.new_date}
  joins:
    - join: brands
      sql_on: ${latest_metrics.key}::int = ${brands.id} and ${latest_metrics.metric} between 4 and 11
      type: left_outer
      relationship: many_to_one
      
    - join: categories
      sql_on: substring(${latest_metrics.key} from 0 for 7) = ${categories.sic_code} and ${latest_metrics.metric} between 12 and 19
      type: left_outer
      relationship: many_to_one
      
    - join: top_countries
      sql_on: ${latest_metrics.country} = ${top_countries.top_10_countries}
      type: left_outer
      relationship: many_to_one
      
    - join: top_categories
      sql_on: substring(${latest_metrics.key} from 0 for 7) = ${top_categories.top_10_categories}
      type: left_outer
      relationship: many_to_one
      
    - join: top_brands
      sql_on: ${latest_metrics.key}::int = ${top_brands.top_10_brand_ids}
      type: left_outer
      relationship: many_to_one
      
    - join: velocity_country
      sql_on: ${latest_metrics.date_date} = ${velocity_country.date_date} and ${latest_metrics.country} = ${velocity_country.country}
      type: left_outer
      relationship: many_to_one
      
    - join: velocity_category
      sql_on: ${latest_metrics.date_date} = ${velocity_category.date_date} and substring(${latest_metrics.key} from 0 for 7) = substring(${velocity_category.category_code} from 0 for 7)
      type: left_outer
      relationship: many_to_one

# - explore: metrics

- explore: top_countries
- explore: top_categories
- explore: top_brands
- explore: velocity_country
- explore: velocity_category
- explore: brands
- explore: categories

# - explore: poi_country
# - explore: poi_brand
# - explore: poi_category
# - explore: bp_brand_approved
#   joins:
#     - join: bp_brand_rejected
#       sql_on: ${bp_brand_rejected.country} = ${bp_brand_approved.country}
#       type: inner
#       relationship: many_to_many
#     - join: bp_brand_need_review
#       sql_on: ${bp_brand_need_review.country} = ${bp_brand_need_review.country}
#       type: inner
#       relationship: many_to_many
# - explore: bp_brand_rejected
# - explore: bp_brand_need_review
# - explore: bp_brand_need_approval
# - explore: bp_brand_need_curation
# - explore: bp_brand_new
# - explore: bp_brand_attempted
# - explore: bp_brand_in_progress
# - explore: bp_category_approved
# - explore: bp_category_rejected
# - explore: bp_category_need_review
# - explore: bp_category_need_approval
# - explore: bp_category_need_curation
# - explore: bp_category_new
# - explore: bp_category_attempted
# - explore: bp_category_in_progress
