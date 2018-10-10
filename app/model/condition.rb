require_relative '../utils'

class Condition
  attr_reader :field,
              :operation,
              :value

  def initialize(field, operation, value)
    @field = Utils::check_type field, String
    @operation = Utils::check_type operation, String
    @value = value
  end

  def to_s
    "#{@field} #{@operation} #{@value}"
  end
end