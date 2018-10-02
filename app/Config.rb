require_relative 'model/PlayerProperty'
require_relative 'model/Player'
require 'json'

class Config
  def initialize(config_file_path)
    data = File.read(config_file_path)
    @json = JSON.parse(data)
  end

  def get_default_player
    player_json = @json['player']
    Player.new player_json['name'].to_s,
               get_player_property(player_json['health']),
               get_player_property(player_json['alcohol']),
               get_player_property(player_json['happiness']),
               get_player_property(player_json['fatigue']),
               get_player_property(player_json['money'])
  end

  private

  def get_player_property(jobj)
    min = jobj.nil? ? nil : jobj['min']
    max = jobj.nil? ? nil : jobj['max']
    value = jobj.nil? ? nil : jobj['value']

    PlayerProperty.new min.nil? ? -Float::INFINITY : min.to_f,
                       max.nil? ? Float::INFINITY : max.to_f,
                       value.nil? ? 0 : value.to_f
  end
end