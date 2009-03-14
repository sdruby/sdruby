module ApplicationHelper

  def current_user
    @controller.send :current_user
  end
  
  def current_user_is?(user)
    current_user == user
  end
  
  def display_flash_using(tag)
    key = [:notice, :warning, :error].find {|key| flash.key?(key)}
    unless key.blank?
      content_tag(tag.to_s, flash[key], :class => "flash #{key}")
    end
  end
  
  def error_messages_for(object_name, options = {})
    options = options.symbolize_keys
    object = instance_variable_get("@#{object_name}")
    if object && !object.errors.empty?
      content_tag("div",
          content_tag("p", "Hey, there&rsquo;s a problem&hellip;") +
          content_tag("ul", object.errors.full_messages.collect { |msg| content_tag("li", msg) }),
          "id" => options[:id] || "errors"
          )
    else
        ""
    end
  end
  
  def request_host
    if RAILS_ENV == "development"
      "http://#{request.host}:#{request.port}"
    else
      "http://sdruby.com"
    end
  end

end
