require_relative '../lib/poker'

RSpec.describe Deck do
    describe '#initialize' do
      subject(:deck) { Deck.new }
  
      it 'initializes with a full set of 52 cards' do
        expect(deck.cards.count).to eq(52)
      end
  
      it 'has no duplicate cards' do
        card_strs = deck.cards.map(&:to_s)
        expect(card_strs.uniq.count).to eq(52)
      end
    end
  
    describe '#deal' do
      subject(:deck) { Deck.new }
  
      it 'deals the specified number of cards' do
        dealt_cards = deck.deal(5)
        expect(dealt_cards.count).to eq(5)
        expect(deck.cards.count).to eq(52 - 5)
      end
    end
  end