require_relative 'player_property'
require_relative 'hashable'
require_relative '../utils'

class Player < Hashable
  attr_reader :name
  attr_accessor :health,
                :alcohol,
                :happiness,
                :fatigue,
                :money

  def initialize(name, health, alcohol, happiness, fatigue, money)
    @name = Utils::check_type name, String
    @health = Utils::check_type health, PlayerProperty
    @alcohol = Utils::check_type alcohol, PlayerProperty
    @happiness = Utils::check_type happiness, PlayerProperty
    @fatigue = Utils::check_type fatigue, PlayerProperty
    @money = Utils::check_type money, PlayerProperty
  end

  def self.create(player_hash)
    Player.new player_hash['name'].to_s,
               PlayerProperty.create(player_hash['health']),
               PlayerProperty.create(player_hash['alcohol']),
               PlayerProperty.create(player_hash['happiness']),
               PlayerProperty.create(player_hash['fatigue']),
               PlayerProperty.create(player_hash['money'])
  end
end