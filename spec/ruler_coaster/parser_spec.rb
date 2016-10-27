describe RulerCoaster do
  context 'Parser' do
    before(:each) do
      @rule = RulerCoaster.parse(json_rule)
    end

    context 'json rule' do
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

    context 'typed rule' do
      context 'default as String' do
        let(:json_rule) {
          {
            type: 'rule',
            path: 'default',
            operator: {
              type: 'equal',
              value: 'Lisboa'
            }
          }
        }

        it 'should compile value to String' do
          expect(@rule.operator.assert_value).to eq('Lisboa')
          expect(@rule.operator.assert_value.class).to eq(String)
        end
      end

      context 'string' do
        let(:json_rule) {
          {
            type: 'rule',
            path: 'string',
            operator: {
              type: 'equal',
              value: 'Porto',
              value_type: 'string'
            }
          }
        }

        it 'should compile value to String' do
          expect(@rule.operator.assert_value).to eq('Porto')
          expect(@rule.operator.assert_value.class).to eq(String)
        end
      end

      context 'number' do
        let(:json_rule) {
          {
            type: 'rule',
            path: 'number',
            operator: {
              type: 'equal',
              value: '1234',
              value_type: 'number'
            }
          }
        }

        it 'should compile value to Fixnum' do
          expect(@rule.operator.assert_value).to eq(1234)
          expect(@rule.operator.assert_value.class).to eq(Fixnum)
        end
      end

      context 'decimal' do
        let(:json_rule) {
          {
            type: 'rule',
            path: 'decimal',
            operator: {
              type: 'equal',
              value: '1234',
              value_type: 'decimal'
            }
          }
        }

        it 'should compile value to Float' do
          expect(@rule.operator.assert_value).to eq(1234.0)
          expect(@rule.operator.assert_value.class).to eq(Float)
        end
      end

      context 'array' do
        let(:json_rule) {
          {
            type: 'rule',
            path: 'array',
            operator: {
              type: 'equal',
              value: '1,2,3,4',
              value_type: 'array'
            }
          }
        }

        it 'should compile value to Array[String]' do
          expect(@rule.operator.assert_value).to eq(['1', '2', '3', '4'])
          expect(@rule.operator.assert_value.class).to eq(Array)
        end
      end

      context 'array 1' do
        let(:json_rule) {
          {
            type: 'rule',
            path: 'array',
            operator: {
              type: 'equal',
              value: ['1', '2', '3', '4']
            }
          }
        }

        it 'should compile value to Array[String]' do
          expect(@rule.operator.assert_value).to eq(['1', '2', '3', '4'])
          expect(@rule.operator.assert_value.class).to eq(Array)
        end
      end

      context 'array[string]' do
        let(:json_rule) {
          {
            type: 'rule',
            path: 'array',
            operator: {
              type: 'equal',
              value: '1,2,3,4',
              value_type: 'array'
            }
          }
        }

        it 'should compile value to Array[String]' do
          expect(@rule.operator.assert_value).to eq(['1', '2', '3', '4'])
          expect(@rule.operator.assert_value.class).to eq(Array)
        end
      end

      context 'array[number]' do
        let(:json_rule) {
          {
            type: 'rule',
            path: 'array',
            operator: {
              type: 'equal',
              value: '1,2,3,4',
              value_type: 'array[number]'
            }
          }
        }

        it 'should compile value to Array[Integer]' do
          expect(@rule.operator.assert_value).to eq([1, 2, 3, 4])
          expect(@rule.operator.assert_value.class).to eq(Array)
        end
      end

      context 'array[decimal]' do
        let(:json_rule) {
          {
            type: 'rule',
            path: 'array',
            operator: {
              type: 'equal',
              value: '1,2,3,4',
              value_type: 'array[decimal]'
            }
          }
        }

        it 'should compile value to Array[Float]' do
          expect(@rule.operator.assert_value).to eq([1.0, 2.0, 3.0, 4.0])
          expect(@rule.operator.assert_value.class).to eq(Array)
        end
      end
    end
  end
end
