require "authlogic/test_case"

module SpecHelpers

  module Authlogic
    def login(user = :user)
      activate_authlogic
      user = user.is_a?(Symbol) ? FactoryGirl.create(user) : user
      user_session = UserSession.create(user)
      user
    end

    def logout
      activate_authlogic
      UserSession.find.destroy
    end
  end

end

RSpec.configure do |config|
  config.include(Authlogic::TestCase)
  config.include(SpecHelpers::Authlogic)

  User.acts_as_authentic_config[:maintain_sessions] = false
end

