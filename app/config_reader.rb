require_relative 'model/player'
require_relative 'model/player_action'
require_relative 'model/player_property'
require_relative 'model/action_result'
require_relative 'model/condition'

module ConfigReader
  def get_default_player
    player_obj = @parsed['player']
    Player.new player_obj['name'].to_s,
               get_player_property(player_obj['health']),
               get_player_property(player_obj['alcohol']),
               get_player_property(player_obj['happiness']),
               get_player_property(player_obj['fatigue']),
               get_player_property(player_obj['money'])
  end

  def get_actions
    actions_obj = @parsed['actions']
    if actions_obj.nil?
      raise ArgumentError, 'actions cannot be nil'
    end

    actions_obj.map {|act| get_action act}
  end

  private

  def get_player_property(obj)
    min = nil
    max = nil
    value = nil

    unless obj.nil?
      min = obj['min']
      max = obj['max']
      value = obj['value']
    end

    PlayerProperty.new min.nil? ? -Float::INFINITY : min.to_f,
                       max.nil? ? Float::INFINITY : max.to_f,
                       value.nil? ? 0 : value.to_f
  end

  def get_action(obj)
    if obj.nil?
      raise ArgumentError, 'obj cannot be nil'
    end

    PlayerAction.new obj['name'].to_s,
                     get_conditions(obj['conditions']),
                     get_results(obj['result'])
  end

  def get_results(obj)
    if obj.nil?
      raise ArgumentError, 'obj cannot be nil'
    end

    obj.map {|res| get_result res}
  end

  def get_result(obj)
    if obj.nil?
      raise ArgumentError, 'obj cannot be nil'
    end

    ActionResult.new obj['field'].to_s,
                     obj['change'].to_f,
                     get_conditions(obj['conditions'])
  end

  def get_conditions(obj)
    if obj.nil?
      return []
    end

    obj.map {|cond| get_condition cond}
  end

  def get_condition(obj)
    if obj.nil?
      raise ArgumentError, 'obj cannot be nil'
    end

    Condition.new obj['field'].to_s,
                  obj['op'].to_s,
                  obj['value'].to_f
  end
end