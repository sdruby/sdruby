class LegacyBase < ActiveRecord::Base
  self.abstract_class = true
  establish_connection "legacy_#{RAILS_ENV.downcase}"
  
  def migrate
    new_record = eval("#{self.class}".gsub(/Legacy/,'')).new(map)
    new_record[:id] = self.id
    new_record.save
  end

end
