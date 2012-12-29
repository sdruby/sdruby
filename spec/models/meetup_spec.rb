require "spec_helper"

describe Meetup do
  before do 
    @meetup = Meetup.new :sdruby
  end

  it 'has a urlname' do
    @meetup.urlname.should_not be_nil
  end

  describe '#events' do
    before do
      VCR.use_cassette('meetup events', record: :none){ @events = @meetup.events }
    end

    it 'returns a collection of events' do
      @events.class.should == RMeetup::Collection
      @events.first.class.should == RMeetup::Type::Event
    end
  end

  describe '#photos' do
    before do
      VCR.use_cassette('meetup photos', record: :none){ @photos = @meetup.photos }
    end

    it 'returns a collection of photos' do
      @photos.class.should == RMeetup::Collection
      @photos.first.class.should == RMeetup::Type::Photo
    end
  end

end