class Hashable
  def to_hash
    hash = {}
    instance_variables.each do |var|
      instance_var = instance_variable_get(var)
      unless instance_var == Float::INFINITY || instance_var == -Float::INFINITY
        hash[var.to_s.delete("@")] = instance_var.respond_to?(:to_hash) ?
                                         instance_var.to_hash :
                                         instance_var
      end
    end

    hash
  end
end