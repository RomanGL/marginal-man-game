require_relative '../model/player'
require_relative '../model/player_action'
require_relative '../model/player_property'
require_relative '../model/action_result'
require_relative '../model/condition'

require 'json'
require 'yaml'

class ConfigReader
  def initialize(config_file_path)
    parse(config_file_path)
  end

  def get_default_player
    player_hash = @parsed['player']
    Player::create player_hash
  end

  def get_actions
    actions_obj = @parsed['actions']
    if actions_obj.nil?
      raise ArgumentError, 'actions cannot be nil'
    end

    actions_obj.map {|act| get_action act}
  end

  protected

  def parse(config_file_path)
    raise NotImplementedError, 'Method must be implemented in descendants.'
  end

  private

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

class ConfigReaderJSON < ConfigReader

  protected

  def parse(config_file_path)
    data = File.read(config_file_path)
    @parsed = JSON.parse(data)
  end
end

class ConfigReaderYAML < ConfigReader

  protected

  def parse(config_file_path)
    @parsed = YAML.load_file(config_file_path)
  end
end