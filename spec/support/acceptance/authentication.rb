module SpecHelpers
  module Acceptance

    module Authentication
      def sign_in(user = :user)
        user = user.is_a?(Symbol) ? FactoryGirl.create(user) : user

        visit root_path
        find("#login").click_link "Login"

        within "form#new_user_session" do
          fill_in "Email", :with => user.email
          fill_in "Password", :with => "password"
          click_button "Login"
        end

        @current_user = user
      end

      def sign_out
        visit "/"
        within("#login") do
          click_on "Logout"
        end
      end

      def current_user
        @current_user
      end
    end

  end
end

RSpec.configure do |config|
  config.include(SpecHelpers::Acceptance::Authentication, :type => :request)
end


