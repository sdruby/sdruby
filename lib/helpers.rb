def help
  Helper.instance
end

class Helper
  include Singleton
  include ActionView::Helpers::DateHelper
end