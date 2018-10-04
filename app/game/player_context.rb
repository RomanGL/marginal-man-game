require_relative 'config_reader'
require_relative 'saves_manager'
require_relative '../model/player'
require_relative '../utils'
require_relative '../invalid_operation_error'

class PlayerContext
  attr_reader :player

  def initialize(player)
    @player = Utils::check_type player, Player
  end
end