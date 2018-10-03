require_relative 'config_reader'
require 'json'

class ConfigReaderJSON
  include ConfigReader

  def initialize(config_file_path)
    data = File.read(config_file_path)
    @parsed = JSON.parse(data)
  end
end