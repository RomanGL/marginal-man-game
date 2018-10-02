require_relative '../Utils'

class ActionResult
  attr_reader :field,
              :change,
              :conditions

  def initialize(field, change, conditions)
    @field = Utils::check_type field, String
    @change = Utils::check_type change, Numeric
    @conditions = conditions
  end
end