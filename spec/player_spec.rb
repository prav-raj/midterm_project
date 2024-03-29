require_relative '../lib/poker'

RSpec.describe Player do
  let(:deck) { Deck.new }
  subject(:player) { Player.new('Test Player') }

  before do
    player.deal_hand(deck)
  end

  describe '#initialize' do
    it 'initializes with a name and a pot' do
      expect(player.name).to eq('Test Player')
      expect(player.pot).to eq(100)
    end

    it 'initializes with an empty hand' do
      expect(player.hand.cards.count).to eq(5)
    end
  end

  describe '#fold' do
    it 'marks the player as folded' do
      player.fold
      expect(player).to be_folded
    end
  end

  # Additional tests for betting logic
end
