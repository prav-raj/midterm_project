require_relative '../lib/poker'

RSpec.describe Card do
    describe '#initialize' do
      subject(:card) { Card.new('Hearts', 'Ace') }
  
      it 'initializes with a suit and value' do
        expect(card.suit).to eq('Hearts')
        expect(card.value).to eq('Ace')
      end
  
      it 'assigns a rank to the value' do
        expect(card.rank).to eq(12) # Ace is the highest, 0-indexed
      end
    end
  
    describe '#to_s' do
      subject(:card) { Card.new('Hearts', '10') }
  
      it 'returns a string representation of the card' do
        expect(card.to_s).to eq('10 of Hearts')
      end
    end
  end