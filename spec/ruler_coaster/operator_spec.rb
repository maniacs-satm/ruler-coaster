describe RulerCoaster do

  context 'Operator' do

    let(:operator) { @operator }
    let(:assert_string_value) { 'London' }
    let(:assert_integer_value) { 2016 }
    let(:assert_array_value) { [1, 2, 3] }

    context 'should parse Equal' do

      context "with string assert value" do

        before(:each) do
          @operator = \
            RulerCoaster.parse(build_operator('equal', assert_string_value))
        end

        it 'should be the right instance' do
          expect(operator).to be_a RulerCoaster::Operator::Equal
        end

        it 'should have value' do
          expect(operator.assert_value).to eq assert_string_value
        end

        it 'should assert true' do
          expect(operator.call('London')).to eq true
        end

        it 'should assert false' do
          expect(operator.call('Lisboa')).to eq false
        end

      end

      context "with integer assert value" do

        before(:each) do
          @operator = \
            RulerCoaster.parse(build_operator('equal', assert_integer_value))
        end

        it 'should be the right instance' do
          expect(operator).to be_a RulerCoaster::Operator::Equal
        end

        it 'should have value' do
          expect(operator.assert_value).to eq assert_integer_value
        end

        it 'should assert true' do
          expect(operator.call(2016)).to eq true
        end

        it 'should assert true 1' do
          expect(operator.call("2016")).to eq true
        end

        it 'should assert false' do
          expect(operator.call(2015)).to eq false
        end

        it 'should assert false 1' do
          expect(operator.call("two015")).to eq false
        end

      end

    end

    context 'should parse Not Equal' do

      before(:each) do
        @operator = \
          RulerCoaster.parse(build_operator('not_equal', assert_string_value))
      end

      it 'should be the right instance' do
        expect(operator).to be_a RulerCoaster::Operator::NotEqual
      end

      it 'should have value' do
        expect(operator.assert_value).to eq assert_string_value
      end

      it 'should assert true' do
        expect(operator.call('London')).to eq false
      end

      it 'should assert false' do
        expect(operator.call('Lisboa')).to eq true
      end

    end

    context 'should parse Greater Than' do

      before(:each) do
        @operator = \
          RulerCoaster.parse \
            build_operator('greater_than', assert_integer_value)
      end

      it 'should be the right instance' do
        expect(operator).to be_a RulerCoaster::Operator::GreaterThan
      end

      it 'should have value' do
        expect(operator.assert_value).to eq assert_integer_value
      end

      it 'should assert true' do
        expect(operator.call(2017)).to eq true
      end

      it 'should assert false' do
        expect(operator.call(2015)).to eq false
      end

    end

    context 'should parse Less Than' do

      before(:each) do
        @operator = \
          RulerCoaster.parse(build_operator('less_than', assert_integer_value))
      end

      it 'should be the right instance' do
        expect(operator).to be_a RulerCoaster::Operator::LessThan
      end

      it 'should have value' do
        expect(operator.assert_value).to eq assert_integer_value
      end

      it 'should assert true' do
        expect(operator.call(2015)).to eq true
      end

      it 'should assert false' do
        expect(operator.call(2017)).to eq false
      end

    end

    context 'should parse Contain' do
      before(:each) do
        @operator = \
          RulerCoaster.parse \
            build_operator('contain', assert_array_value, 'array[number]')
      end

      it 'should be the right instance' do
        expect(operator).to be_a RulerCoaster::Operator::Contain
      end

      it 'should have value' do
        expect(operator.assert_value).to eq assert_array_value
      end

      it 'should assert true' do
        expect(operator.call(2)).to eq true
      end

      it 'should assert false' do
        expect(operator.call(5)).to eq false
      end
    end

    context 'should parse Not Contain' do
      let(:assert_array_value) { ['1', '2', '3'] }

      before(:each) do
        @operator = \
          RulerCoaster.parse \
            build_operator('not_contain', assert_array_value, 'array[number]')
      end

      it 'should be the right instance' do
        expect(operator).to be_a RulerCoaster::Operator::NotContain
      end

      it 'should have value' do
        expect(operator.assert_value).to eq [1, 2, 3]
      end

      it 'should assert true' do
        expect(operator.call(5)).to eq true
      end

      it 'should assert false' do
        expect(operator.call(2)).to eq false
      end
    end

    context 'should parse Empty' do
      before(:each) do
        @operator = \
          RulerCoaster.parse(build_operator('empty'))
      end

      it 'should be the right instance' do
        expect(operator).to be_a RulerCoaster::Operator::Empty
      end

      it 'should have value' do
        expect(operator.assert_value).to be_empty
      end

      it 'should assert true' do
        expect(operator.call('')).to eq true
      end

      it 'should assert false' do
        expect(operator.call('abc')).to eq false
      end
    end

    context 'should parse Not Empty' do
      before(:each) do
        @operator = \
          RulerCoaster.parse(build_operator('not_empty'))
      end

      it 'should be the right instance' do
        expect(operator).to be_a RulerCoaster::Operator::NotEmpty
      end

      it 'should have value' do
        expect(operator.assert_value).to be_empty
      end

      it 'should assert true' do
        expect(operator.call('abc')).to eq true
      end

      it 'should assert false' do
        expect(operator.call('')).to eq false
      end
    end
  end
end
