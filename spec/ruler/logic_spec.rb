describe Ruler do

  context 'Logic' do

    let(:logic) { @logic }

    context 'And' do

      before(:each) do
        @logic = \
          Ruler.parse \
            build_logic \
              'and',
              build_rule('from', 'equal', 'Lisboa'),
              build_rule('to', 'equal', 'Porto')
      end

      it 'should be the right instances' do
        expect(logic).to be_a Ruler::Logic::And
        expect(logic.left).to be_a Ruler::Rule
        expect(logic.right).to be_a Ruler::Rule
      end

      it 'should assert true' do
        expect(logic.call(from: 'Lisboa', to: 'Porto').success?).to eq true
      end

      it 'should assert false' do
        expect(logic.call(from: 'Lisboa', to: 'Braga').success?).to eq false
      end

    end

    context 'Not' do

      before(:each) do
        @logic = \
          Ruler.parse \
            build_logic \
              'not',
              build_rule('from', 'equal', 'Lisboa'),
              build_rule('to', 'equal', 'Porto')
      end

      it 'should be the right instances' do
        expect(logic).to be_a Ruler::Logic::Not
        expect(logic.left).to be_a Ruler::Rule
        expect(logic.right).to be_a Ruler::Rule
      end

      it 'should assert true 1' do
        expect(logic.call(from: 'Braga', to: 'Leiria').success?).to eq true
      end

      it 'should assert true 2' do
        expect(logic.call(from: 'Braga', to: 'Porto').success?).to eq true
      end

      it 'should assert true 3' do
        expect(logic.call(from: 'Lisboa', to: 'Braga').success?).to eq true
      end

      it 'should assert false' do
        expect(logic.call(from: 'Lisboa', to: 'Porto').success?).to eq false
      end

    end

    context 'Or' do

      before(:each) do
        @logic = \
          Ruler.parse \
            build_logic \
              'and',
              build_rule('from', 'equal', 'Lisboa'),
              build_logic(
                'or',
                build_rule('to', 'equal', 'Porto'),
                build_rule('to', 'equal', 'Braga')
              )
      end

      it 'should be the right instances' do
        expect(logic).to be_a Ruler::Logic::And
        expect(logic.left).to be_a Ruler::Rule
        expect(logic.right).to be_a Ruler::Logic::Or
      end

      it 'should assert true 1' do
        expect(logic.call(from: 'Lisboa', to: 'Porto').success?).to eq true
      end

      it 'should assert true 2' do
        expect(logic.call(from: 'Lisboa', to: 'Braga').success?).to eq true
      end

      it 'should assert false 1' do
        expect(logic.call(from: 'Porto', to: 'Braga').success?).to eq false
      end

      it 'should assert false 2' do
        expect(logic.call(from: 'Lisboa', to: 'Leiria').success?).to eq false
      end

    end

    context 'Nor' do

      before(:each) do
        @logic = \
          Ruler.parse \
            build_logic \
              'and',
              build_rule('from', 'equal', 'Lisboa'),
              build_logic(
                'nor',
                build_rule('to', 'equal', 'Porto'),
                build_rule('to', 'equal', 'Braga')
              )
      end

      it 'should be the right instances' do
        expect(logic).to be_a Ruler::Logic::And
        expect(logic.left).to be_a Ruler::Rule
        expect(logic.right).to be_a Ruler::Logic::Nor
      end

      it 'should assert true 1' do
        expect(logic.call(from: 'Lisboa', to: 'Leiria').success?).to eq true
      end

      it 'should assert true 2' do
        expect(logic.call(from: 'Lisboa', to: 'Aveiro').success?).to eq true
      end

      it 'should assert false 1' do
        expect(logic.call(from: 'Porto', to: 'Leiria').success?).to eq false
      end

      it 'should assert false 2' do
        expect(logic.call(from: 'Lisboa', to: 'Braga').success?).to eq false
      end

    end

  end

end
