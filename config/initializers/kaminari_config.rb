Kaminari.configure do |config|
  config.default_per_page = 3
  config.max_per_page = 10
  config.window = 4
  config.outer_window = 1
  config.left = 0
  config.right = 0
  config.page_method_name = :page
  config.param_name = :page
  config.max_pages = nil
  config.params_on_first_page = false
end
