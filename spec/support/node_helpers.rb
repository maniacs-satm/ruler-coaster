module NodeHelpers

  def build_logic(type, left, right)
    {
      type: type,
      left: left,
      right: right
    }
  end

  def build_rule(path, operator, value)
    {
      type: "rule",
      path: path,
      operator: build_operator(operator, value)
    }
  end

  def build_operator(type, value = nil, value_type = nil)
    { type: type, value: value }.tap do |hash|
      unless value_type.nil?
        hash[:value_type] = value_type
      end
    end
  end

end
