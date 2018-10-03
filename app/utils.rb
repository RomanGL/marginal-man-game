module Utils
  def self.check_type(value, expected_type)
    unless value.is_a? expected_type
      raise ArgumentError, "Argument is not #{expected_type} (#{caller_locations(1..1).first})"
    end

    value
  end

  def self.clear_screen
    Gem.win_platform? ? (system 'cls') : (system 'clear')
  end
end