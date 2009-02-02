require 'test/unit/testresult'
module Test
  module Unit
    class TestResult
      def add_failure(failure)
        failure = Test::Unit::Failure.new(failure.test_name, failure.location, failure.message + "\nFixture Key: #{FuzzyFixture.last_key}")
        @failures << failure
        notify_listeners(FAULT, failure)
        notify_listeners(CHANGED, self)
      end
    end
    class Error
      def long_display
        backtrace = filter_backtrace(@exception.backtrace).join("\n    ")
        "Error:\n#@test_name:\n#{message}\n    #{backtrace}\n    Fixture Key: #{FuzzyFixture.last_key}"
      end
    end
  end
end