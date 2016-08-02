describe Ruler do

  context 'Operator' do

    let(:operator) { @operator }
    let(:assert_string_value) { 'London' }
    let(:assert_integer_value) { 2016 }
    let(:assert_array_value) { [1, 2, 3] }

    context 'should parse Equal' do

      before(:each) do
        @operator = \
          Ruler.parse(build_operator('equal', assert_string_value))
      end

      it 'should be the right instance' do
        expect(operator).to be_a Ruler::Operator::Equal
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

    context 'should parse Not Equal' do

      before(:each) do
        @operator = \
          Ruler.parse(build_operator('not_equal', assert_string_value))
      end

      it 'should be the right instance' do
        expect(operator).to be_a Ruler::Operator::NotEqual
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
          Ruler.parse(build_operator('greater_than', assert_integer_value))
      end

      it 'should be the right instance' do
        expect(operator).to be_a Ruler::Operator::GreaterThan
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
          Ruler.parse(build_operator('less_than', assert_integer_value))
      end

      it 'should be the right instance' do
        expect(operator).to be_a Ruler::Operator::LessThan
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
          Ruler.parse(build_operator('contain', assert_array_value))
      end

      it 'should be the right instance' do
        expect(operator).to be_a Ruler::Operator::Contain
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

      before(:each) do
        @operator = \
          Ruler.parse(build_operator('not_contain', assert_array_value))
      end

      it 'should be the right instance' do
        expect(operator).to be_a Ruler::Operator::NotContain
      end

      it 'should have value' do
        expect(operator.assert_value).to eq assert_array_value
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
          Ruler.parse(build_operator('empty'))
      end

      it 'should be the right instance' do
        expect(operator).to be_a Ruler::Operator::Empty
      end

      it 'should have value' do
        expect(operator.assert_value).to be_nil
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
          Ruler.parse(build_operator('not_empty'))
      end

      it 'should be the right instance' do
        expect(operator).to be_a Ruler::Operator::NotEmpty
      end

      it 'should have value' do
        expect(operator.assert_value).to be_nil
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
