require_relative 'config_reader'
require 'yaml'

class ConfigReaderYAML
  include ConfigReader

  def initialize(config_file_path)
    @parsed = YAML.load_file(config_file_path)
  end
end