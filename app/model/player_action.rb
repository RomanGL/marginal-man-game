require_relative '../utils'

class PlayerAction
  attr_reader :name,
              :results,
              :conditions

  def initialize(name, conditions, result)
    @name = Utils::check_type name, String
    @conditions = conditions
    @results = result
  end

  def to_s
    "#{@name}, conditions #{@conditions}, result #{@results}"
  end
end