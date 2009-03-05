# MIGRATION HELPER

def migrate(name, options={})
  # Grab custom entity label if present
  label = options.delete(:label) if options[:label]
  
  unless options[:helper]
    model = name.to_s.singularize.capitalize
    model.constantize.delete_all

    puts "Migrating #{number_of_records || "all"} #{label || name} #{"after #{offset_for_records}" if offset_for_records}"
    "Legacy#{model}".constantize.find(:all, with(options)).each do |record|
      record.migrate
    end
  else
    eval options[:helper].to_s
  end
end

def with(options={})
  {:limit => number_of_records, :offset => offset_for_records}.merge(options)
end

def number_of_records
  nil || ENV['limit'].to_i if ENV['limit'].to_i > 0
end

def offset_for_records
  nil || ENV['offset'].to_i if ENV['offset'].to_i > 0
end