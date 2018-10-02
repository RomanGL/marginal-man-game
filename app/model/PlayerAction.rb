require_relative '../Utils'

class PlayerAction
  attr_reader :name,
              :result

  def initialize(name, result)
    @name = Utils::check_type name, String
    @result = result
  end
end