require_relative '../lib/poker'

RSpec.describe Card do
  subject(:card) { Card.new('Hearts', '10') }

  describe '#initialize' do
    it 'assigns a suit' do
      expect(card.suit).to eq('Hearts')
    end

    it 'assigns a value' do
      expect(card.value).to eq('10')
    end
  end
end