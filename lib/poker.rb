class Card
    attr_reader :suit, :value
  
    def initialize(suit, value)
      @suit = suit
      @value = value
    end
  end
  
  class Deck
    attr_reader :cards
  
    def initialize
      @cards = build_deck.shuffle
    end
  
    def deal_card
      @cards.pop
    end

    def shuffle
        @cards.shuffle!
    end
  
    private
  
    def build_deck
      suits = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
      values = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
      suits.product(values).map { |suit, value| Card.new(suit, value) }
    end
  end
  
  class Hand
    attr_accessor :cards
  
    def initialize(cards = [])
      @cards = cards
    end
  
    def evaluate_hand
      # Add implementation for evaluating hand value
    end
  end

  class Player
    attr_reader :name, :hand, :pot
  
    def initialize(name, pot)
      @name = name
      @hand = Hand.new
      @pot = pot # Starting pot for betting
    end
  
    def discard_cards(card_indices)
      card_indices.each do |index|
        @hand.cards.delete_at(index)
      end
    end
  
    def draw_cards(deck, number)
      number.times { @hand.cards << deck.deal_card }
    end
  end

  