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

private

  def client
    RMeetup::Client
  end

end