require_relative 'model/Player'
require_relative 'model/PlayerProperty'
require_relative 'Config'

c = Config.new 'config.json'
default_pl = c.get_default_player

puts default_pl.name
puts default_pl.health.to_s
puts default_pl.alcohol.to_s
puts default_pl.happiness.to_s
puts default_pl.fatigue.to_s
puts default_pl.money.to_s