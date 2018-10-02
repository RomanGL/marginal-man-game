require_relative '../utils'

class PlayerAction
  attr_reader :name,
              :result

  def initialize(name, conditions, result)
    @name = Utils::check_type name, String
    @conditions = conditions
    @result = result
  end

  def to_s
    "#{@name}, conditions #{@conditions}, result #{@result}"
  end
end