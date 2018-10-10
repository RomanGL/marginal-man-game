require_relative '../utils'
require_relative '../errors'
require_relative 'game_view'

class GameContext
  def initialize(player, actions, saves_manager)
    @player = Utils::check_type player, Player
    @saves_manager = Utils::check_type saves_manager, SavesManager
    @actions = actions
  end

  def save
    @saves_manager.save_player @player
    GameView::print_game_saved
  end

  def start
    update until game_over?
    game_over
  end

  private

  def update
    GameView::print_actions @actions
    GameView::print_player_details @player
    action = get_action
    Utils::clear_screen

    return if action.nil?
    apply action if conditions_valid? action.conditions, true
  end

  def get_action
    GameView::print_input_invitation
    input = gets.chomp
    if input == 'm'
      update_pause_menu
      return
    end
    unless Utils::is_integer? input
      return nil
    end

    id = input.to_i - 1
    if id < 0 && id >= @actions.length
      nil
    else
      @actions[id]
    end
  end

  def update_pause_menu
    while true
      Utils::clear_screen
      GameView::print_pause_menu
      GameView::print_input_invitation

      case gets.chomp.to_i
      when 1
        return
      when 2
        save
        return
      when 3
        save if save_game?
        raise EndGameError, 'Return to the main menu.'
      when 4
        save if save_game?
        exit
        return
      end
    end
  end

  def save_game?
    while true
      Utils::clear_screen
      GameView::print_save_game_question
      GameView::print_input_invitation

      case gets.chomp
      when 'y'
        Utils::clear_screen
        return true
      when 'n'
        Utils::clear_screen
        return false
      end
    end
  end

  def conditions_valid?(conditions, print_invalid)
    flag = true
    conditions.each do |cond|
      variable = Utils::get_variable_by_field self, cond.field
      unless variable.value.method(cond.operation).(cond.value)
        flag = false
        GameView::print_invalid_condition cond if print_invalid
      end
    end

    flag
  end

  def apply(action)
    action.results.each do |res|
      if conditions_valid? res.conditions, false
        variable = Utils::get_variable_by_field self, res.field
        variable.change_value res.change
      end
    end
  end

  def game_over?
    if @player.health.value <= @player.health.min ||
        @player.fatigue.value >= @player.fatigue.max
      return true
    end
  end

  def game_over
    Utils::clear_screen
    GameView::print_game_over
  end
end