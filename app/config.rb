require_relative 'model/player'
require_relative 'model/player_action'
require_relative 'model/player_property'
require_relative 'model/action_result'
require_relative 'model/condition'
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

  def get_actions
    actions_jobj = @json['actions']
    if actions_jobj.nil?
      raise ArgumentError, 'actions cannot be nil'
    end

    actions_jobj.map {|act| get_action act}
  end

  private

  def get_player_property(jobj)
    min = nil
    max = nil
    value = nil

    unless jobj.nil?
      min = jobj['min']
      max = jobj['max']
      value = jobj['value']
    end

    PlayerProperty.new min.nil? ? -Float::INFINITY : min.to_f,
                       max.nil? ? Float::INFINITY : max.to_f,
                       value.nil? ? 0 : value.to_f
  end

  def get_action(jobj)
    if jobj.nil?
      raise ArgumentError, 'jobj cannot be nil'
    end

    PlayerAction.new jobj['name'].to_s,
                     get_conditions(jobj['conditions']),
                     get_results(jobj['result'])
  end

  def get_results(jobj)
    if jobj.nil?
      raise ArgumentError, 'jobj cannot be nil'
    end

    jobj.map {|res| get_result res}
  end

  def get_result(jobj)
    if jobj.nil?
      raise ArgumentError, 'jobj cannot be nil'
    end

    ActionResult.new jobj['field'].to_s,
                     jobj['change'].to_f,
                     get_conditions(jobj['conditions'])
  end

  def get_conditions(jobj)
    if jobj.nil?
      return []
    end

    jobj.map {|cond| get_condition cond}
  end

  def get_condition(jobj)
    if jobj.nil?
      raise ArgumentError, 'jobj cannot be nil'
    end

    Condition.new jobj['field'].to_s,
                  jobj['op'].to_s,
                  jobj['value'].to_f
  end
end