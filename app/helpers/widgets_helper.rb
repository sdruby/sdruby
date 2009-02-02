module WidgetsHelper
  
  def default
  end
  
  def next_meeting
    @event = Meeting.next
  end
  
  def next_event
    @events = Event.find(:all, :conditions => ["starts_at > ? AND is_private = ?", Time.now, false ], :order => "starts_at", :limit => 3)
  end
  
  def random_member
    member_id = rand(User.count) + 1
    @member = User.find_by_id(member_id) || User.find(:first)
  end
    
end
