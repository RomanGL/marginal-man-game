require_relative 'model/player'
require_relative 'model/player_property'
require_relative 'config'

c = Config.new 'config.json'
default_pl = c.get_default_player
actions = c.get_actions

puts actions.to_s