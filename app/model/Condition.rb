require_relative '../Utils'

class Condition
  attr_reader :field,
              :operation,
              :value

  def initialize(field, operation, value)
    @field = Utils::check_type field, String
    @operation = Utils::check_type operation, String
    @value = value
  end
end