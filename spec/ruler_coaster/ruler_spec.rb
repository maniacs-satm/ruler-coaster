describe RulerCoaster do

  context 'No Result' do

    it 'should return no result if nil' do
      result = \
        RulerCoaster::Rule.new('gender', RulerCoaster::Operator::Equal.new('m'))
          .call(gender: nil)

      expect(result).to be_a RulerCoaster::NoResult
      expect(result.success?).to eq false
    end

    it 'should not return no result if nil but operator is Empty' do
      result = \
        RulerCoaster::Rule.new('gender', RulerCoaster::Operator::Empty.new)
          .call(gender: nil)

      expect(result).to be_a RulerCoaster::Result
      expect(result.success?).to eq true
    end

    it 'should not return no result if nil but operator is NotEmpty' do
      result = \
        RulerCoaster::Rule.new('gender', RulerCoaster::Operator::NotEmpty.new)
          .call(gender: nil)

      expect(result).to be_a RulerCoaster::Result
      expect(result.success?).to eq false
    end

  end

  context 'Examples' do

    context 'Only user males above 20 from Porto, PT rule' do

      before(:each) do
        @rule = \
          RulerCoaster::Rule.new('user.gender', RulerCoaster::Operator::Equal.new('m'))
            .and(RulerCoaster::Rule.new('user.location.city', RulerCoaster::Operator::Equal.new('Porto')))
            .and(RulerCoaster::Rule.new('user.location.country', RulerCoaster::Operator::Equal.new('PT')))
            .and(RulerCoaster::Rule.new('user.age', RulerCoaster::Operator::GreaterThan.new(20)))
      end

      it 'should fail' do
        result = @rule.call({
          user: {
            age: 21,
            gender: 'm',
            location: {
              city: 'Porto',
              country: 'PT'
            }
          }
        })

        expect(result.success?).to eq(true)
      end

    end

    context 'Only user males above 20 from Porto or London rule' do

      before(:each) do
        @rule = \
          RulerCoaster::Rule.new('user.gender', RulerCoaster::Operator::Equal.new('m'))
            .and(
              RulerCoaster::Rule.new('user.age', RulerCoaster::Operator::GreaterThan.new(20))
                .and(
                  (
                    RulerCoaster::Rule.new('user.location.city', RulerCoaster::Operator::Equal.new('Porto'))
                      .and(RulerCoaster::Rule.new('user.location.country', RulerCoaster::Operator::Equal.new('PT')))
                  ).or(
                    RulerCoaster::Rule.new('user.location.city', RulerCoaster::Operator::Equal.new('London'))
                      .and(RulerCoaster::Rule.new('user.location.country', RulerCoaster::Operator::Equal.new('UK')))
                  )
                )
              )
      end

      it 'should pass' do
        result = @rule.call({
          user: {
            age: 21,
            gender: 'm',
            location: {
              city: 'Porto',
              country: 'PT'
            }
          }
        })

        expect(result.success?).to eq(true)
      end

      it 'should fail' do
        result = @rule.call({
          user: {
            age: 21,
            gender: 'm',
            location: {
              city: 'Manchester',
              country: 'UK'
            }
          }
        })

        expect(result.success?).to eq(false)
      end

    end

    context 'No males from Porto neither London' do

      before(:each) do
        @rule = \
          RulerCoaster::Rule.new('user.location.city', RulerCoaster::Operator::Equal.new('Porto'))
            .nor(RulerCoaster::Rule.new('user.location.city', RulerCoaster::Operator::Equal.new('London')))
      end

      it 'should pass' do
        result = @rule.call({
          user: {
            location: {
              city: 'Leeds'
            }
          }
        })

        expect(result.success?).to eq(true)
      end

      it 'should fail' do
        result = @rule.call({
          user: {
            location: {
              city: 'London'
            }
          }
        })

        expect(result.success?).to eq(false)
      end

      it 'should fail 2' do
        result = @rule.call({
          user: {
            location: {
              city: 'Porto'
            }
          }
        })

        expect(result.success?).to eq(false)
      end

    end

    context "No males that haven't studied in Porto and London" do

      before(:each) do
        @rule = \
          RulerCoaster::Rule.new('user.univ_1', RulerCoaster::Operator::Equal.new('Porto'))
            .not(RulerCoaster::Rule.new('user.univ_2', RulerCoaster::Operator::Equal.new('London')))
      end

      it 'should pass' do
        result = @rule.call({
          user: {
            univ_1: 'Porto',
            univ_2: 'London'
          }
        })

        expect(result.success?).to eq(false)
      end

      it 'should fail' do
        result = @rule.call({
          user: {
            univ_1: 'Porto',
            univ_2: 'Lisboa'
          }
        })

        expect(result.success?).to eq(true)
      end

    end

  end

end
