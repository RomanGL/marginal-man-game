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

  def self.is_integer?(value)
    Integer(value) != nil rescue false
  end

  def self.get_variable_by_field(start_obj, field)
    fields = field.split('.')

    variable = start_obj
    fields.each do |field_name|
      variable = variable.instance_variable_get "@" + field_name
    end

    variable
  end
end