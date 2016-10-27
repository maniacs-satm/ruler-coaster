describe RulerCoaster do
  context 'Attributes' do
    before(:each) do
      @group = \
        RulerCoaster::Attributes::Base.new \
          age: [
            RulerCoaster::Rule.new('age', RulerCoaster::Operator::GreaterThan.new(20)),
            RulerCoaster::Rule.new('age', RulerCoaster::Operator::LessThan.new(25))
          ],
          gender: [RulerCoaster::Rule.new('gender', RulerCoaster::Operator::Equal.new('m'))]
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
