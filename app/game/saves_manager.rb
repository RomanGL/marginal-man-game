require_relative '../model/player'

require 'json'
require 'yaml'

class SavesManager
  def initialize(save_file_path)
    @save_file_path = save_file_path
  end

  def save_player(player)
    player_hash = player.to_hash
    serialized = serialize player_hash
    File.write @save_file_path, serialized
  end

  def load_player
    parsed = parse
    Player.create parsed
  end

  protected

  def serialize(hash)
    raise NotImplementedError, 'Method must be implemented in descendants'
  end

  def parse
    raise NotImplementedError, 'Method must be implemented in descendants.'
  end
end

class SavesManagerJSON < SavesManager

  protected

  def serialize(hash)
    JSON.pretty_generate hash
  end

  def parse
    data = File.read(@save_file_path)
    JSON.parse(data)
  end
end

class SavesManagerYAML < SavesManager

  protected

  def serialize(hash)
    hash.to_yaml
  end

  def parse
    YAML.load_file(@save_file_path)
  end
end