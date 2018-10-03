require_relative 'config_reader'
require_relative 'saves_manager'
require_relative '../model/player'
require_relative '../utils'
require_relative '../invalid_operation_error'

class PlayerContext
  @player = nil

  def initialize(config_reader, saves_manager)
    @config_reader = Utils::check_type config_reader, ConfigReader
    @saves_manager = Utils::check_type saves_manager, SavesManager
  end

  def save
    raise_if_not_loaded

    player_hash = @player.to_hash
    @saves_manager.save_player player_hash
  end

  def load
    raise_if_loaded
  end

  def load_default
    raise_if_loaded

    @player = @config_reader.get_default_player
  end

  def loaded?
    @player.nil? == false
  end

  private

  def raise_if_loaded
    if loaded?
      raise InvalidOperationError.new 'Player context already loaded'
    end
  end

  def raise_if_not_loaded
    unless loaded?
      raise InvalidOperationError.new 'Player context is not loaded'
    end
  end
end