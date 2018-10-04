require_relative 'game/saves_manager'
require_relative 'game/config_reader'
require_relative 'game/player_context'
require_relative 'game/game_factory'
require_relative 'utils'

def start
  puts 'Marginal Man'

  while true do
    puts "\n1 - New game\n2 - Load game\n3 - Exit\n"
    print "\nPlease choose one: "

    n = gets.chomp.to_i
    Utils::clear_screen

    case n
    when 1
      new_game
      return
    when 2
      load_game
      return
    when 3
      exit
    else
      puts 'Wrong input. Try again.'
    end
  end
end

def new_game
  game_context = GameFactory::get_new_game_context
end

def load_game
  game_context = GameFactory::get_saved_game_context
end

start