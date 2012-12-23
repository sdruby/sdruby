class ApplicationController

  def meetup
    @meetup ||= OpenStruct.new(
      events: [
        OpenStruct.new(time: 1.month.from_now),
        OpenStruct.new(time: 2.months.from_now)
      ],
      photos: []
    )
  end

end