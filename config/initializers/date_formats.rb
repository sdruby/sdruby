Time::DATE_FORMATS[:descriptive] = lambda { |time| time.strftime("%A, %B #{time.day} @ #{time.hour > 12 ? (time.hour - 12) : time.hour}:%M %p")}
