# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'db24fa1f12cedfd2184dc9156cd2e704'

  # THIS IS TEMPORARY, UNTIL WE GET AUTHENTICATION FIGURED OUT
  def current_user
    @current_user ||= User.find(388298128)
  end
  # END OF TEMPORARY
end
