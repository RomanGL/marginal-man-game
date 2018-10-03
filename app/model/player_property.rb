require_relative 'hashable'
require_relative '../utils'

class PlayerProperty < Hashable
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

  def self.create(property_hash)
    min = nil
    max = nil
    value = nil

    unless property_hash.nil?
      min = property_hash['min']
      max = property_hash['max']
      value = property_hash['value']
    end

    PlayerProperty.new min.nil? ? -Float::INFINITY : min.to_f,
                       max.nil? ? Float::INFINITY : max.to_f,
                       value.nil? ? 0 : value.to_f
  end
end