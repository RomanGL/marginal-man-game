require_relative 'game/saves_manager'
require_relative 'game/config_reader'
require_relative 'game/game_factory'
require_relative 'game/game_view'
require_relative 'utils'

def start
  puts 'Marginal Man'

  while true do
    GameView::print_main_menu
    n = gets.chomp.to_i

    case n
    when 1
      new_game
    when 2
      load_game
    when 3
      exit
    else
      puts 'Wrong input. Try again.'
    end
  end
end

def new_game
  game_context = GameFactory::get_new_game_context
  start_game game_context
end

def load_game
  begin
    game_context = GameFactory::get_saved_game_context
  rescue NoSaveFileError
    Utils::clear_screen
    GameView::print_no_saved_game
    return
  end

  start_game(game_context)
end

def start_game(game_context)
  Utils::clear_screen
  begin
    game_context.start
  rescue EndGameError
  end
end

start