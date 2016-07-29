module Ruler

  module Parser

    extend self

    def parse(root)
      visit(symbolyze_keys(root))
    end

    def visit(node)
      send("visit_#{node[:type]}", node)
    end

    def visit_and(node)
      Logic::And.new(visit(node[:left]), visit(node[:right]))
    end

    def visit_not(node)
      Logic::Not.new(visit(node[:left]), visit(node[:right]))
    end

    def visit_or(node)
      Logic::Or.new(visit(node[:left]), visit(node[:right]))
    end

    def visit_nor(node)
      Logic::Nor.new(visit(node[:left]), visit(node[:right]))
    end

    def visit_rule(node)
      Rule.new(node[:path], visit(node[:operator]))
    end

    def visit_equal(node)
      Operator::Equal.new(node[:value])
    end

    def visit_not_equal(node)
      Operator::NotEqual.new(node[:value])
    end

    def visit_greater_than(node)
      Operator::GreaterThan.new(node[:value])
    end

    def visit_less_than(node)
      Operator::LessThan.new(node[:value])
    end

    def visit_contain(node)
      Operator::Contain.new(node[:value])
    end

    def visit_not_contain(node)
      Operator::NotContain.new(node[:value])
    end

    def visit_empty(node)
      Operator::Empty.new(node[:value])
    end

    def visit_not_empty(node)
      Operator::NotEmpty.new(node[:value])
    end

    def symbolyze_keys(hash)
      {}.tap do |symbolyzed_hash|
        hash.each do |key, value|
          symbolyzed_hash[key.to_sym] = \
            if value.is_a?(Hash)
              symbolyze_keys(value)
            else
              value
            end
        end
      end
    end

  end

end
