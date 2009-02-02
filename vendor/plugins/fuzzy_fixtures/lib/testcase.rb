module Test #:nodoc:
  module Unit #:nodoc:
    class TestCase #:nodoc:
      def self.fuzzy(*table_names)
        table_names = table_names.flatten.map { |n| n.to_s }
        table_names.each do |name_key|
          if match = name_key.match(/\d+/)
            name = match.pre_match
            new_string = "#{name.classify}, #{match[0]}"
          else
            name = name_key
            new_string = "#{name.classify}"
          end
          code = <<CODE
          def fuzzy_#{name}
            @fuzzy_#{name} ||= FuzzyFixture.new(#{new_string})
          end
CODE
          eval(code)
        end
      end
    end
  end
end