- dashboard: blueprints
  title: Blueprints Dashboard
  layout: static
  tile_size: 50
  width: 1800
  refresh: 30 minutes

  filters:
  
  - name: Date
    title: 'Date'
    type: field_filter
    explore: metrics
    field: metrics.date_date
    
  - name: Country
    title: 'Country'
    type: field_filter
    explore: metrics
    field: metrics.country
    
  - name: Category
    title: 'Category'
    type: field_filter
    explore: categories
    field: categories.category_name
    
  - name: Brand
    title: 'Brand'
    type: field_filter
    explore: brands
    field: brands.brand_name
    
#     listens_to_filters: [publisher_type, publisher, ad_vendor, traffic_src, banner_size, timeline]
#     
#   - name: timeline
#     title: 'Timeline'
#     type: field_filter
#     explore: publisher_revenue_summary
#     field: publisher_revenue_summary.timestamp_date
#     default_value: '6 months'

  elements:

  - name: poi_title
    type: text
    title_text: "POI"
    top: 0
    left: 0
    height: 1
    width: 8
    
  - name: bp_title
    type: text
    title_text: "BLUEPRINTS"
    top: 0
    left: 9
    height: 1
    width: 27
    
  - name: poi_count_by_country
    title: "POI Count By Country"
    type: looker_column
    model: poi
    explore: metrics
    dimensions: [metrics.date_date, top_countries.top_10_countries]
    pivots: [top_countries.top_10_countries]
    measures: [metrics.total_poi_brand]
    filters:
      top_countries.date: 2016/09/01
      metrics.date_date: '2016'
    sorts: [metrics.date_date, metrics.country, top_countries.top_10_countries desc]
    limit: '500'
    column_limit: '50'
    query_timezone: America/Los_Angeles
    stacking: normal
    totals_color: '#808080'
    x_axis_scale: ordinal
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    series_colors: {}
    show_view_names: false
    ordering: desc
    top: 1
    left: 0
    height: 7
    width: 8
    
  - name: bp_by_country_and_velocity
    title: "BP by Country and Velocity"
    type: table
    model: poi
    explore: latest_metrics
    dimensions: [latest_metrics.country]
    measures: [latest_metrics.brand_count, latest_metrics.brand_completed_count, latest_metrics.brand_in_progress_count,
      latest_metrics.total_bp_count_brand, latest_metrics.total_bp_percentage_brand,
      latest_metrics.total_approved_count_brand, latest_metrics.total_in_progress_count_brand,
      latest_metrics.total_rejected_count_brand, latest_metrics.total_rejected_percentage_brand,
      velocity_country.velocity]
    filters:
      latest_metrics.date: 2016/09/01
      top_countries.date: 2016/09/01
    sorts: [latest_metrics.total_bp_count_brand desc]
    limit: '500'
    column_limit: '50'
    query_timezone: America/Los_Angeles
    table_theme: gray
    top: 1
    left: 9
    height: 7
    width: 19
    
  - name: poi_count_by_category
    title: "POI Count by Category"
    type: looker_column
    model: poi
    explore: metrics
    dimensions: [metrics.date_date, top_categories.top_10_category_names]
    pivots: [top_categories.top_10_category_names]
    measures: [metrics.total_poi_category]
    filters:
      top_categories.date: 2016/09/01
      metrics.date_date: '2016'
    sorts: [metrics.date_date, metrics.country, top_countries.top_10_countries desc,
      top_categories.top_10_category_names]
    limit: '500'
    column_limit: '50'
    query_timezone: America/Los_Angeles
    stacking: normal
    totals_color: '#808080'
    x_axis_scale: ordinal
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    series_colors: {}
    show_view_names: false
    ordering: desc
    top: 9
    left: 0
    height: 7
    width: 8
    
  - name: bp_by_category_and_velocity
    title: "BP by Category and Velocity"
    type: table
    model: poi
    explore: latest_metrics
    dimensions: [categories.category_name]
    measures: [latest_metrics.total_bp_count_category, latest_metrics.total_bp_percentage_category,
      latest_metrics.total_approved_count_category, latest_metrics.total_in_progress_count_category,
      latest_metrics.total_rejected_count_category, velocity_category.velocity]
    filters:
      latest_metrics.date: 2016/09/01
      top_categories.date: 2016/09/01
      velocity_category.date_date: 2016/09/01
    sorts: [latest_metrics.total_bp_count_category desc]
    limit: '500'
    column_limit: '50'
    query_timezone: America/Los_Angeles
    table_theme: gray
    top: 9
    left: 9
    height: 7
    width: 19
    
  - name: total_poi_and_bp_by_country_and_brand
    title: "Total POI and Blueprinted by Country and Brand"
    type: table
    model: poi
    explore: latest_metrics
    dimensions: [brands.brand_name, latest_metrics.country]
    pivots: [latest_metrics.country]
    measures: [latest_metrics.total_poi_brand, latest_metrics.total_bp_count_brand]
    filters:
      latest_metrics.date: 2016/09/01
      top_brands.date: 2016/09/01
    sorts: [latest_metrics.country desc, latest_metrics.total_bp_count_brand desc 0]
    limit: '500'
    column_limit: '50'
    row_total: left
    query_timezone: America/Los_Angeles
    table_theme: gray
    series_labels:
      latest_metrics.total_bp_count_brand: BP'ed
      latest_metrics.total_poi_brand: POI
    top: 17
    left: 0
    height: 11
    width: 36
    
  - name: velocity_by_country
    title: " "
    type: looker_line
    model: poi
    explore: metrics
    dimensions: [metrics.date_date, top_countries.top_10_countries]
    pivots: [top_countries.top_10_countries]
    measures: [velocity_country.velocity]
    filters:
      top_countries.date: 2016/09/01
      velocity_country.date_date: '2016'
    sorts: [metrics.date_date, top_countries.top_10_countries]
    limit: '500'
    column_limit: '50'
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: '22'
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    series_types:
      __FILE: poi/blueprints.dashboard.lookml
      __LINE_NUM: 206
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    series_colors:
      __FILE: poi/blueprints.dashboard.lookml
      __LINE_NUM: 209
    top: 1
    left: 28
    height: 7
    width: 8
    
  - name: velocity_by_category
    title: " "
    type: looker_line
    model: poi
    explore: metrics
    dimensions: [metrics.date_date, top_categories.top_10_category_names]
    pivots: [top_categories.top_10_category_names]
    measures: [velocity_category.velocity]
    filters:
      top_categories.date: 2016/09/01
      velocity_category.date_date: '2016'
    sorts: [metrics.date_date, top_categories.top_10_category_names]
    limit: '500'
    column_limit: '50'
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: false
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    series_types:
      __FILE: poi/blueprints.dashboard.lookml
      __LINE_NUM: 206
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    series_colors:
      __FILE: poi/blueprints.dashboard.lookml
      __LINE_NUM: 209
    top: 9
    left: 28
    height: 7
    width: 8





