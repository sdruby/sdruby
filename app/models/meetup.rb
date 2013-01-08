class Meetup
  attr_reader :urlname

  def initialize(urlname)
    @urlname = urlname
  end

  def events
    @events ||= client.fetch(:events, group_urlname: urlname)
  end

  def photos
    @photos ||= client.fetch(:photos, group_urlname: urlname)
  end

  def next_event
    events.first
  end

  def date
    next_event.time.strftime("%A, %B %e")
  end

  def time
    next_event.time.strftime("%l:%M%P,")
  end

  def venue
    if next_event.venue_name.match(/Monk/)
      return "Monk Development"
    elsif next_event.venue_name.match(/UCSD/)
      return "UCSD CSE Building"
    else
      next_event.venue_name
    end
  end

  def address
    @address ||= begin
      address = ''
      address << [next_event.venue_address1, next_event.venue_address2, next_event.venue_city, next_event.venue_state].reject(&:blank?).join(',')
      address << " #{next_event.venue_zip}"
      address
    end
  end

  def map_url
    if venue.match(/UCSD/)
      'http://tinyurl.com/2f486e'
    else
      "https://maps.google.com/maps?daddr=#{URI.escape(address)}"
    end
  end

private

  def client
    RMeetup::Client
  end

end