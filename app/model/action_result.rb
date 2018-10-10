require_relative '../utils'

class ActionResult
  attr_reader :field,
              :change,
              :conditions

  def initialize(field, change, conditions)
    @field = Utils::check_type field, String
    @change = Utils::check_type change, Numeric
    @conditions = conditions
  end

  def to_s
    "#{@field}, change #{@change}, conditions #{@conditions}"
  end
end