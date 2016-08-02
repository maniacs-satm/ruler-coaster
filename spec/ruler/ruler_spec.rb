describe Ruler do

  context 'No Result' do

    it 'should return no result if nil' do
      result = \
        Ruler::Rule.new('gender', Ruler::Operator::Equal.new('m'))
          .call(gender: nil)

      expect(result).to be_a Ruler::NoResult
      expect(result.success?).to eq false
    end

    it 'should not return no result if nil but operator is Empty' do
      result = \
        Ruler::Rule.new('gender', Ruler::Operator::Empty.new)
          .call(gender: nil)

      expect(result).to be_a Ruler::Result
      expect(result.success?).to eq true
    end

    it 'should not return no result if nil but operator is NotEmpty' do
      result = \
        Ruler::Rule.new('gender', Ruler::Operator::NotEmpty.new)
          .call(gender: nil)

      expect(result).to be_a Ruler::Result
      expect(result.success?).to eq false
    end

  end

  context 'Examples' do

    context 'Only user males above 20 from Porto, PT rule' do

      before(:each) do
        @rule = \
          Ruler::Rule.new('user.gender', Ruler::Operator::Equal.new('m'))
            .and(Ruler::Rule.new('user.location.city', Ruler::Operator::Equal.new('Porto')))
            .and(Ruler::Rule.new('user.location.country', Ruler::Operator::Equal.new('PT')))
            .and(Ruler::Rule.new('user.age', Ruler::Operator::GreaterThan.new(20)))
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
          Ruler::Rule.new('user.gender', Ruler::Operator::Equal.new('m'))
            .and(
              Ruler::Rule.new('user.age', Ruler::Operator::GreaterThan.new(20))
                .and(
                  (
                    Ruler::Rule.new('user.location.city', Ruler::Operator::Equal.new('Porto'))
                      .and(Ruler::Rule.new('user.location.country', Ruler::Operator::Equal.new('PT')))
                  ).or(
                    Ruler::Rule.new('user.location.city', Ruler::Operator::Equal.new('London'))
                      .and(Ruler::Rule.new('user.location.country', Ruler::Operator::Equal.new('UK')))
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
          Ruler::Rule.new('user.location.city', Ruler::Operator::Equal.new('Porto'))
            .nor(Ruler::Rule.new('user.location.city', Ruler::Operator::Equal.new('London')))
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
          Ruler::Rule.new('user.univ_1', Ruler::Operator::Equal.new('Porto'))
            .not(Ruler::Rule.new('user.univ_2', Ruler::Operator::Equal.new('London')))
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
