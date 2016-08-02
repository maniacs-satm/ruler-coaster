module RulerCoaster
  class Rule
    include Logic::Mixin

    attr_reader :path,
                :operator

    def initialize(path, operator)
      @path = path.split('.')
      @operator = operator
    end

    def call(object)
      input = navigate(object, path)

      if input.nil? && !operator.is_a?(Operator::Empty)
        NoResult.new(self, input)
      else
        Result.new(self, input, operator.call(input))
      end
    end

    private

    def navigate(object, navigation_path)
      object = RulerCoaster::Parser.symbolyze_keys(object)

      navigation_path = navigation_path.dup

      next_key = navigation_path.shift.to_sym

      if !navigation_path.empty?
        navigate(object[next_key], navigation_path)
      else
        object[next_key]
      end
    rescue
      raise NavigationError, "cannot navigate to #{path} on #{object.inspect}"
    end
  end
end
