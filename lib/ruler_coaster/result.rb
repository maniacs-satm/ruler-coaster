module RulerCoaster
  class Result
    attr_reader :rule,
                :input

    def initialize(rule, input, success)
      @rule = rule
      @input = input
      @success = success
    end

    def success?
      @success == true
    end

    def negation
      @success = !@success

      self
    end
  end
end
