require_relative '../lib/poker'

RSpec.describe Game do
    let(:player_names) { ['Alice', 'Bob'] }
    let(:game) { Game.new(player_names) }
  
    before do
      allow_any_instance_of(Deck).to receive(:shuffle!)
      player_names.each do |name|
        allow_any_instance_of(Player).to receive(:deal_hand)
      end
    end
  
    describe '#initialize' do
      it 'creates a new deck' do
        expect(game.instance_variable_get(:@deck)).to be_a(Deck)
      end
  
      it 'initializes players with names and default pots' do
        expect(game.instance_variable_get(:@players).first.name).to eq('Alice')
        expect(game.instance_variable_get(:@players).first.pot).to eq(100) # assuming default pot is 100
      end
    end
  
    describe '#play_round' do
      before do
        allow(game).to receive(:deal_hands)
        allow(game).to receive(:betting_phase)
        allow(game).to receive(:discard_phase)
        allow(game).to receive(:reveal_hands)
      end
  
      it 'plays through a round of poker' do
        expect(game).to receive(:deal_hands)
        expect(game).to receive(:betting_phase).twice
        expect(game).to receive(:discard_phase)
        expect(game).to receive(:reveal_hands)
        game.play_round
      end
    end
end
