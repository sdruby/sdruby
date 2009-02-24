Haml::Template.options = { :attr_wrapper => '"' }
Sass::Plugin.options = { :template_location => "#{RAILS_ROOT}/public/sass", 
                         :css_location => "#{RAILS_ROOT}/public/stylesheets" }
Sass::Plugin.update_stylesheets