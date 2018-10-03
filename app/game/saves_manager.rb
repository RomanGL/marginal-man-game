require 'json'
require 'yaml'

class SavesManager
  def initialize(file_path)
    @file_path = file_path
  end

  def save_player(player)
    player_hash = player.to_hash
    serialized = serialize player_hash
    File.write @file_path, serialized
  end

  protected

  def serialize(hash)
    raise NotImplementedError, 'Method must be implemented in descendants'
  end
end

class SavesManagerJSON < SavesManager

  protected

  def serialize(hash)
    JSON.pretty_generate hash
  end
end

class SavesManagerYAML < SavesManager

  protected

  def serialize(hash)
    hash.to_yaml
  end
end