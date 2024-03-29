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