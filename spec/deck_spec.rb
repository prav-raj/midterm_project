require_relative '../lib/poker'

RSpec.describe Deck do
  subject(:deck) { Deck.new }

  describe '#initialize' do
    it 'creates a deck with 52 cards' do
      expect(deck.cards.count).to eq(52)
    end

    it 'creates a deck with unique cards' do
      expect(deck.cards.uniq.count).to eq(52)
    end
  end

  describe '#shuffle' do
    it 'calls shuffle! on the cards array' do
      deck = Deck.new
      # Assuming @cards is accessible for this test; otherwise, use a different strategy
      cards_double = deck.instance_variable_get("@cards")
      allow(cards_double).to receive(:shuffle!).and_return(cards_double)

      deck.shuffle

      expect(cards_double).to have_received(:shuffle!)
    end
  end

  describe '#deal_card' do
    it 'removes a card from the deck' do
      expect { deck.deal_card }.to change { deck.cards.count }.by(-1)
    end
  end
end