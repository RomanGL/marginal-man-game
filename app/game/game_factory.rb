require_relative 'config_reader'
require_relative 'saves_manager'
require_relative 'game_context'

module GameFactory
  def self.get_new_game_context
    config_reader = ConfigReaderYAML.new 'config/config.yml'
    saves_manager = SavesManagerYAML.new 'save.yml'

    player_context = PlayerContext.new config_reader.get_default_player
    actions = config_reader.get_actions

    GameContext.new player_context, actions, saves_manager
  end

  def self.get_saved_game_context
    raise NoSaveFileError, 'File save.yml does not exists.' unless File.exist? '../save.yml'

    config_reader = ConfigReaderYAML.new 'config/config.yml'
    saves_manager = SavesManagerYAML.new 'save.yml'

    player_context = PlayerContext.new saves_manager.load_player
    actions = config_reader.get_actions
    GameContext.new player_context, actions, saves_manager
  end
end