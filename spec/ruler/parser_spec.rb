describe Ruler do

  context "Parser" do

    let(:json_rule) {
      {
        type: "and",
        left: {
          type: "rule",
          path: "from",
          operator: {
            type: "equal",
            value: "Lisboa"
          }
        },
        right: {
          type: "or",
          left: {
            type: "rule",
            path: "to",
            operator: {
              type: "equal",
              value: "Porto"
            }
          },
          right: {
            type: "rule",
            path: "to",
            operator: {
              type: "equal",
              value: "Braga"
            }
          }
        }
      }
    }

    let(:nested_json_rule) {
      {
        type: "rule",
        path: "a.b.c",
        operator: {
          type: "equal",
          value: "Nested"
        }
      }
    }

    before(:each) do
      @rule = Ruler::Parser.parse(json_rule)
    end

    it "should compile json to Rule" do
      expect(@rule).to be_a(Ruler::Logic::And)
      expect(@rule.left).to be_a(Ruler::Rule)
      expect(@rule.right).to be_a(Ruler::Logic::Or)
      expect(@rule.right.left).to be_a(Ruler::Rule)
      expect(@rule.right.right).to be_a(Ruler::Rule)
    end

    it "should run Rule against an object" do
      expect(@rule.({ from: "Lisboa", to: "Porto" }).success?).to eq(true)
      expect(@rule.({ from: "Lisboa", to: "Braga" }).success?).to eq(true)
      expect(@rule.({ from: "Lisboa", to: "Leiria" }).success?).to eq(false)
    end

    it "should run Rule against a top level object" do
      result = Ruler::Parser.parse(nested_json_rule).({ a: { b: { c: "Nested"} } })

      expect(result.success?).to eq(true)

      result = Ruler::Parser.parse(nested_json_rule).({ a: { b: { c: "Nope"} }})

      expect(result.success?).to eq(false)

      expect{ Ruler::Parser.parse(nested_json_rule).({ a: { b: 1 }}) }.to \
        raise_error(Ruler::NavigationError)
    end

  end

end
