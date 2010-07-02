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

  def check_if_active(controller)
  
    if @controller.controller_name == controller.to_s
      return "active"
    elsif @controller.action_name == controller.to_s
      return "active"
    else
      return nil
    end

  end
  
  def next_meeting_date
    
    today = Date.today
    beginning_of_current_month = Date.today.beginning_of_month
    beginning_of_next_month = Date.today.next_month.beginning_of_month
    
    while beginning_of_current_month <= today do
      if beginning_of_current_month.strftime("%A") == "Thursday"
        return beginning_of_current_month
      end
      beginning_of_current_month += 1.day
    end
    
    loop do
      return beginning_of_next_month if beginning_of_next_month.strftime("%A") == "Thursday"
      beginning_of_next_month += 1.day
    end
    
  end
  
end

