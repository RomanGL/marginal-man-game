require_relative '../utils'
require_relative 'player_context'
require_relative 'game_view'

class GameContext
  def initialize(player_context, actions, saves_manager)
    @player_context = Utils::check_type player_context, PlayerContext
    @saves_manager = Utils::check_type saves_manager, SavesManager
    @actions = actions
  end

  def save
    @saves_manager.save_player @player_context.player
    GameView::print_game_saved
  end

  def start
    update while true
  end

  private

  def update
    GameView::print_player_details @player_context.player
    GameView::print_actions @actions
  end
end