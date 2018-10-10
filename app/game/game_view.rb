require_relative '../colorized_string'

module GameView
  def self.print_game_saved
    puts 'Game saved successful!'.green
  end

  def self.print_no_saved_game
    puts 'You dont have saved game.'.red
  end

  def self.print_main_menu
    puts "\n1 - New game\n2 - Load game\n3 - Exit\n"
    print "\nPlease choose one: "
  end

  def self.print_actions(actions)
    puts "\nYou can:".green
    i = 1
    actions.each do |a|
      puts "#{i} - #{a.name}"
      i += 1
    end

    puts "\nm - Menu"
  end

  def self.print_player_details(player)
    puts "\n#{player.name}'s details".green
    puts "Name \t\tvalue\t(min -> max)".light_blue
    puts "Health: \t#{player.health.value} \t(#{player.health.min} -> #{player.health.max})"
    puts "Alcohol: \t#{player.alcohol.value} \t(#{player.alcohol.min} -> #{player.alcohol.max})"
    puts "Happiness: \t#{player.happiness.value} \t(#{player.happiness.min} -> #{player.happiness.max})"
    puts "Fatigue: \t#{player.fatigue.value} \t(#{player.fatigue.min} -> #{player.fatigue.max})"
    puts "Money: \t\t#{player.money.value} \t(#{player.money.min} -> #{player.money.max})"
  end

  def self.print_input_invitation
    print "\nEnter your choice: ".light_blue
  end

  def self.print_invalid_condition(condition)
    puts "Invalid condition: expected #{condition.field} #{condition.operation} #{condition.value}".red
  end

  def self.print_game_over
    puts "GAME OVER".red
  end

  def self.print_pause_menu
    puts "PAUSED\n".green
    puts '1 - Resume'
    puts '2 - Save game'
    puts '3 - Main menu'
    puts '4 - Exit'
  end

  def self.print_save_game_question
    puts 'Do you want to save the game? (y/n)'.green
  end
end