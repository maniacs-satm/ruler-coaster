describe RulerCoaster do

  context 'Parser' do

    let(:json_rule) {
      {
        type: 'and',
        left: {
          type: 'rule',
          path: 'from',
          operator: {
            type: 'equal',
            value: 'Lisboa'
          }
        },
        right: {
          type: 'or',
          left: {
            type: 'rule',
            path: 'to',
            operator: {
              type: 'equal',
              value: 'Porto'
            }
          },
          right: {
            type: 'rule',
            path: 'to',
            operator: {
              type: 'equal',
              value: 'Braga'
            }
          }
        }
      }
    }

    let(:nested_json_rule) {
      {
        type: 'rule',
        path: 'a.b.c',
        operator: {
          type: 'equal',
          value: 'Nested'
        }
      }
    }

    before(:each) do
      @rule = RulerCoaster.parse(json_rule)
    end

    it 'should compile json to Rule' do
      expect(@rule).to be_a(RulerCoaster::Logic::And)
      expect(@rule.left).to be_a(RulerCoaster::Rule)
      expect(@rule.right).to be_a(RulerCoaster::Logic::Or)
      expect(@rule.right.left).to be_a(RulerCoaster::Rule)
      expect(@rule.right.right).to be_a(RulerCoaster::Rule)
    end

    it 'should run Rule against an object' do
      expect(@rule.call({ from: 'Lisboa', to: 'Porto' }).success?).to eq(true)
      expect(@rule.call({ from: 'Lisboa', to: 'Braga' }).success?).to eq(true)
      expect(@rule.call({ from: 'Lisboa', to: 'Leiria' }).success?).to eq(false)
    end

    it 'should run Rule against a top level object' do
      result = RulerCoaster.parse(nested_json_rule).call({ a: { b: { c: 'Nested'} } })

      expect(result.success?).to eq(true)

      result = RulerCoaster.parse(nested_json_rule).call({ a: { b: { c: 'Nope'} }})

      expect(result.success?).to eq(false)

      expect{ RulerCoaster.parse(nested_json_rule).call({ a: { b: 1 }}) }.to \
        raise_error(RulerCoaster::NavigationError)
    end

  end

end
