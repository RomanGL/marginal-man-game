require_relative 'PlayerProperty'
require_relative '../Utils'

class Player
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
end