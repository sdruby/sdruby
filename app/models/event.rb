class Event < ActiveRecord::Base

  def self.types
    ['Event', 'Meeting']
  end

  def self.next
    self.find(:first, :conditions => ["starts_at > ? AND is_private = ?", Time.now, false ], :order => "starts_at ASC")
  end

end
