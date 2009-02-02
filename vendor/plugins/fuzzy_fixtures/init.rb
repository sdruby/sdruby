path = File.expand_path(File.dirname(__FILE__) + '/lib/')
dir = Dir.new(path)
dir.entries.each do |file|
  next unless file.match(/\.rb$/)
  require path + "/" + file
end

FUZZY_CONFIG_FILE = File.expand_path(RAILS_ROOT + "/config/fuzzy.yml")

old_config = File.expand_path(RAILS_ROOT + "/config/factories.yml")
if File.exists?(old_config)
  FileUtils.move(old_config, FUZZY_CONFIG_FILE)
end

FileUtils.touch(FUZZY_CONFIG_FILE) unless File.exists?(FUZZY_CONFIG_FILE)
FuzzyFixture.config = YAML.load_file FUZZY_CONFIG_FILE

