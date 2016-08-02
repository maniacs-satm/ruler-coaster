module RulerCoaster
  class NoResult < Result
    attr_reader :rule,
                :input

    def initialize(rule, input)
      super(rule, input, false)
    end

    def negation
      self
    end
  end
end
