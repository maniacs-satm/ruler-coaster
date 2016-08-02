describe Ruler do

  context 'Coaster' do

    before(:each) do
      @group = \
        Ruler::Coaster::Base.new \
          age: [
            Ruler::Rule.new('age', Ruler::Operator::GreaterThan.new(20)),
            Ruler::Rule.new('age', Ruler::Operator::LessThan.new(25))
          ],
          gender: [Ruler::Rule.new('gender', Ruler::Operator::Equal.new('m'))]
    end

    it 'should return error keys' do
      result = @group.(age: 19, gender: 'm')

      expect(result.success?).to eq(false)

      expect(result.errors[:age]).to include('is invalid')
    end

    it 'should return blocked keys' do
      result = @group.(age: nil, gender: 'm')

      expect(result.success?).to eq(false)
      expect(result.blocked).to include(:age)
    end

  end

end
