class PlayerProperty
  attr_reader :min,
              :max,
              :value

  def initialize(min, max, value)
    @min = min
    @max = max
    @value = value
  end

  def +(other)
    raise ArgumentError, 'Argument is not numeric' unless other.is_a? Numeric

    res = @value + other
    if res > @max
      PlayerProperty.new(@min, @max, @max)
    elsif res < @min
      PlayerProperty.new(@min, @max, @min)
    else
      PlayerProperty.new(@min, @max, res)
    end
  end

  def -(other)
    raise ArgumentError, 'Argument is not numeric' unless other.is_a? Numeric

    res = @value - other
    if res > @max
      PlayerProperty.new(@min, @max, @max)
    elsif res < @min
      PlayerProperty.new(@min, @max, @min)
    else
      PlayerProperty.new(@min, @max, res)
    end
  end

  def to_s
    "min = #{@min}, max = #{@max}, value = #{@value}"
  end
end