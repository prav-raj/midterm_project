require_relative '../lib/poker'

RSpec.describe Hand do
    let(:deck) { Deck.new }
    subject(:hand) { Hand.new(deck.deal(5)) }
  
    describe '#initialize' do
      it 'initializes with five cards' do
        expect(hand.cards.count).to eq(5)
      end
    end
  
    describe '#discard and #draw' do
      it 'discards specified cards and draws new ones' do
        hand.discard([0, 1])
        hand.draw(deck, 2)
        expect(hand.cards.count).to eq(5)
      end
    end
  
    # Add tests for #evaluate_hand and #highest_card based on your implementation details
  end