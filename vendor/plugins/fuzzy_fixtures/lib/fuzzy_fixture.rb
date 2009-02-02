class FuzzyFixture
  cattr_accessor :config
  cattr_accessor :last_key

  class FuzzyException < RuntimeError #:nodoc:
    def initialize(args)
      e = args[0]
      last_options = args[1]
      super("raised #{e.class}: #{e.message}\nYour args where:\n#{last_options.inspect}\n\n")
      set_backtrace(e.backtrace)
    end
  end


  attr_accessor :columns, :key, :klass, :last_options, :klass_settings
  def initialize(klass, key=nil)
    #verify klass exists and that parent is active record
    if klass && klass < ActiveRecord::Base
      @klass = klass      
      @klass_settings = FuzzyFixture.config[@klass.to_s.tableize] if FuzzyFixture.config      
      @klass_settings ||= {}
    else
      raise "Class #{klass} not found or not an ActiveRecord"
    end
    unless key
      #No key assigns so populate random key, then capture it
      srand
      key = srand
    end
    srand key
    @key = key
    setup_key
    @last_options = {}
    @any = (32..126).to_a.collect do |i|
      i.chr
    end
    @alpha = ('a'..'z').to_a + ('A'..'Z').to_a
    @numeric = ('0'..'9').to_a
    @alphanumeric = @alpha + @numeric
    @tlas = ["net", "com", "org", "biz", "xxx", "it", "us", "name"]
  end
  
=begin rdoc
This method generates a random set of columns via generate_columns and then creates 
and instance of the ActiveRecord via it's create call.
=end
  def create(options = {})
    generate_columns(options)
    @klass.create(@last_options)
  end
  
=begin rdoc
Generates a new model object, throws and exception if the object is not valid,
printing what is not valid and why
=end
  def create!(options = {})
    generate_columns(options)
    begin
      @klass.create!(@last_options)
    rescue Exception => e
      raise FuzzyException, [e, @last_options]
    end
  end

  def columns(options = {})
    setup_key
    unless @columns
      @columns = {}
      @klass.content_columns.each do |col|
        next unless methods.include?(col.type.to_s)
        settings = @klass_settings[col.name] || {}
        settings.symbolize_keys!
        args = {}
        args[:max] = col.limit
        args[:default] = col.default
        args[:nil] = col.null
        #not everyone does scale
        begin
          args[:scale] = col.scale
        rescue
        end
        begin
          args[:precision] = col.precision
        rescue
        end
        args[:column_name] = col.name
        args.merge!(settings)
        @columns[col.name.to_sym] = [col.type.to_s, args]
      end
      @columns = @columns.merge(options)
    end
    @columns
  end

=begin rdoc
This method can be used to get a hash of columns with random values.  This is especially
useful for filling params values in controller tests:
  post :action => :create, :person => person_factory.generate_columns
=end
  def generate_columns(options = {})
    columns.each do |key, code|
      @last_options[key] = send(code[0], code[1])
    end
    options = options_sub_symbols(options)
    @last_options = @last_options.merge(options)
  end

=begin rdoc
 General options that can be applied to all keys others are sent on to their
 value method (ie. string, boolean, etc)
=end
  def options_sub_symbols(options)
    options.each do |key, value|
      if value.class == Symbol
        col = @klass.columns_hash[key.to_s]
        case value
        when :short
          options[key] = send(col.type, {:max => 1, :min => 1})
        when :long
          options[key] = send(col.type, {:max => 255, :min => 255})
        when :empty
          options[key] = ""
        else
          options[key] = send(col.type, {value => true})
        end
      end
    end
    options
  end

=begin
    :binary      => { :name => "blob" },
=end

=begin rdoc
Arguments for type decimal can be:
  [*scale*] (integer value) = 2
  [*precision*] (integer value) = 8
  [*default*]  (true or false) = false
  [*default_percent*] (integer value) = 25
  [*nil*]      (true or false) = false
  [*nil_percent*] (1-100) = 1
=end
  def decimal(args = {})
    finished,value = default_and_nil(args)
    return value if finished
    
    precision = args[:precision] || 8
    scale = args[:scale] || 2
    precision -= scale
    integer_part = integer(:max => (10 ** (precision - 1)), :min => -1 * (10 ** (precision - 1)))
    decimal_part = integer(:min => -1 * (10 ** (scale - 1)), :max => (10 ** (scale - 1)), :unsigned => true)
    s = "#{integer_part}.#{decimal_part}"
    return BigDecimal.new(s)
  end
=begin rdoc
Arguments for type time can be:
[*default*]  (true or false) = false
[*default_percent*] (integer value) = 25
[*nil*]      (true or false) = false
[*nil_percent*] (1-100) = 1  
=end

  def time(args = {})
    finished,value = default_and_nil(args)
    return value if finished
    
    year = "#{rand(133) + 1904}".rjust(4,"0")
    month = "#{rand(12) + 1}".rjust(2,"0")
    day = "#{rand(31) + 1}".rjust(2,"0")
    
    hour = "#{rand 23 + 1}".rjust(2,"0")
    minute = "#{rand 59 + 1}".rjust(2,"0")
    second = "#{rand 59 + 1}".rjust(2,"0")
    s = "#{year}-#{month}-#{day} #{hour}:#{minute}:#{second}"
    return Time.parse(s)
  end
  alias datetime time
  alias timestamp time

=begin rdoc
Arguments for type date can be:
[*default*]  (true or false) = false
[*default_percent*] (integer value) = 25
[*nil*]      (true or false) = false
[*nil_percent*] (1-100) = 1  
=end

  def date(args = {})
    finished,value = default_and_nil(args)
    return value if finished
    
    year = "#{rand 3000}".rjust(4,"0")
    month = "#{rand(12) + 1}".rjust(2,"0")
    day = "#{rand(31) + 1}".rjust(2,"0")
    #Normalize the date, note this will never be Feb 29th
    time = Time.parse("2001-#{month}-#{day}")
    s = "#{year}-#{time.month}-#{time.day}"
    return Date.parse(s)
  end

=begin rdoc
Arguments for type float can be:
[*default*]  (true or false) = false
[*default_percent*] (integer value) = 25
[*max*]    (integer value) = 309 (exponent)
[*nil*]      (true or false) = false
[*nil_percent*] (1-100) = 1  
[*unsigned*] (true or false) = false
=end
  def float(args = {})
    #return the default half the time
    finished,value = default_and_nil(args)
    return value if finished
    max = args[:max] || 309
    exponent = rand max
    return rand * 9 ** exponent if args[:unsigned]

    if boolean
      return rand * 9 ** exponent
    else
      return (rand * 9 ** exponent) * -1
    end

  end

=begin rdoc
Arguments for type text, same as string
=end
  def text(args = {})
    string(:max => 1024)
  end
  
=begin rdoc
Arguments for type integer can be:
[*default*] (true or false) = false
[*default_percent*] (1-100) = 25
[*nil*] (true or false) = false
[*nil_percent*] (1-100) = 1
[*max*] (integer value) = + 2 ** 63 - 1
[*min*] (integer value = - 2 ** 63 - 1 (or 1 if unsigned)
[*unsigned*] (true or false) = false
=end

  def integer(args = {})
    finished,value = default_and_nil(args)
    return value if finished

    max = args[:max] || 2 ** 63 - 1
    if args[:unsigned]
      min = args[:min] || 1
      return rand(max - min + 1) + min
    else
      min = args[:min] || 2 ** 63 - 1
    end
    
    if boolean
      return rand(max - min + 1) + min
    else
      return rand(max - min + 1) + min * -1
    end
  end

=begin rdoc
Arguments for type boolean can be:
[*default*] (true or false) = false
[*default_percent*] (1-100) = 25
[*nil*] (true or false) = false
[*nil_percent*] (1-100) = 1
=end
  def boolean(args = {})
    finished,value = default_and_nil(args)
    return value if finished
    
    return (rand 2).zero?
  end

=begin rdoc
Arguments for type integer can be:
[*default*] (true or false) = false
[*default_percent*] (1-100) = 25
[*max*] (integer value) = 255
[*min*] (integer value) = 1
[*nil*] (true or false) = false
[*nil_percent*] (1-100) = 1
[*type*] (email, or some other type) = false
[*characters*] (:any, :alpha, :alphanumeric, :numeric) = ascii printable
=end
  def string(args = {})
    finished,value = default_and_nil(args)
    return value if finished
    
    return send(args[:type]) if args[:type]

    max = args[:max] || 255
    size = set_size(max, (args[:min] || 1))
    chars = eval("@#{args[:characters]}") if args[:characters]
    chars ||= @any
    return (1..size).collect{|a| chars[rand(chars.size)] }.join
  end
      
  def method_missing(*args)
    puts "don't know #{args.inspect}"
    return nil
  end
  
  private
  def default_and_nil(args)
    return true,args[:default] if args[:default] && ((rand 100) < (args[:default_percent] || 25))
    return true,nil if args[:nil] && ((rand 100) < (args[:nil_percent] || 1))
    return false,nil
  end
    
  def set_size(max, min)
    size = rand(max - min + 1) + min
  end
  
  def setup_key
    @@last_key = @key
  end
end
