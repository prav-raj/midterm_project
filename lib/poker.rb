class Card
    include Comparable
    attr_reader :suit, :value, :rank
  
    VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']
  
    def initialize(suit, value)
      @suit = suit
      @value = value
      @rank = VALUES.index(value)
    end
  
    def to_s
      "#{value} of #{suit}"
    end
  
    def <=>(other)
      self.rank <=> other.rank
    end
  end
  
  class Deck
    attr_reader :cards
    SUITS = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
    VALUES = Card::VALUES
  
    def initialize
      @cards = SUITS.product(VALUES).map { |suit, value| Card.new(suit, value) }
      shuffle!
    end
  
    def shuffle!
      @cards.shuffle!
    end
  
    def deal(n)
      @cards.shift(n)
    end
  end
  
  class Hand
    attr_reader :cards
  
    def initialize(cards)
      @cards = cards
    end
  
    def discard(indices)
      indices.each do |index|
        @cards[index] = nil
      end
      @cards.compact!
    end
  
    def draw(deck, n)
      @cards += deck.deal(n)
    end
  
    def to_s
      @cards.map(&:to_s).join(', ')
    end

    def evaluate_hand
        values = @cards.map(&:rank)
        suits = @cards.map(&:suit)
        value_counts = values.each_with_object(Hash.new(0)) { |value, counts| counts[value] += 1 }
        straight = values.each_cons(2).all? { |x, y| y == x + 1 }
        flush = suits.uniq.size == 1
    
        case
        when straight && flush
          :straight_flush
        when value_counts.any? { |_, count| count == 4 }
          :four_of_a_kind
        when value_counts.any? { |_, count| count == 3 } && value_counts.any? { |_, count| count == 2 }
          :full_house
        when flush
          :flush
        when straight
          :straight
        when value_counts.any? { |_, count| count == 3 }
          :three_of_a_kind
        when value_counts.select { |_, count| count == 2 }.size == 2
          :two_pair
        when value_counts.any? { |_, count| count == 2 }
          :one_pair
        else
          :high_card
        end
    end

    def highest_card
        @cards.max
      end
  end
  
  class Player
    attr_accessor :pot
    attr_reader :name, :hand
  
    def initialize(name, pot = 100)
      @name = name
      @hand = nil
      @pot = pot
      @folded = false
    end
  
    def deal_hand(deck)
      @hand = Hand.new(deck.deal(5))
    end
  
    def fold
      @folded = true
    end
  
    def folded?
      @folded
    end
  
    def show_hand
      puts "#{name}'s hand: #{hand}"
    end
  end
  
  class Game
    HAND_STRENGTH = {
        high_card: 1,
        one_pair: 2,
        two_pair: 3,
        three_of_a_kind: 4,
        straight: 5,
        flush: 6,
        full_house: 7,
        four_of_a_kind: 8,
        straight_flush: 9
      }
    def initialize(player_names)
      @deck = Deck.new
      @players = player_names.map { |name| Player.new(name) }
      @pot = 0
      @current_bet = 0
    end
  
    def play_round
      @deck = Deck.new
      deal_hands
      betting_phase("Initial")
      discard_phase
      betting_phase("Final")
      reveal_hands unless @players.select { |player| !player.folded? }.count <= 1
    end
  
    private
  
    def deal_hands
      @players.each { |player| player.deal_hand(@deck) unless player.folded? }
    end
  
    def betting_phase(phase_name)
      puts "#{phase_name} Betting Phase:"
      @players.each do |player|
        next if player.folded?
        player.show_hand 
        action = player_decision(player)
        case action
        when 'fold'
          player.fold
          puts "#{player.name} folds."
        when 'see'
          player.pot -= @current_bet
          @pot += @current_bet
          puts "#{player.name} sees the bet."
        when 'raise'
          raise_amount = 10 
          @current_bet += raise_amount
          player.pot -= @current_bet
          @pot += @current_bet
          puts "#{player.name} raises the bet."
        end
      end
    end
  
    def discard_phase
      puts "Discard Phase:"
      @players.each do |player|
        next if player.folded?
        player.show_hand 
        puts "#{player.name}, enter the number of cards to discard (up to 3):"
        num_discard = gets.to_i
        next if num_discard == 0
        puts "Enter indices of cards to discard:"
        indices = gets.split.map(&:to_i).uniq[0,3] 
        player.hand.discard(indices)
        player.hand.draw(@deck, indices.size)
      end
    end
  
    def player_decision(player)
      puts "#{player.name}, do you want to fold, see, or raise? (pot: #{player.pot})"
      action = gets.strip.downcase
      ['fold', 'see', 'raise'].include?(action) ? action : 'fold'
    end

    def reveal_hands
        puts "Reveal Hands:"
        best_hand = nil
        winning_player = nil
    
        @players.each do |player|
          next if player.folded?
          player.show_hand
          hand_strength = player.hand.evaluate_hand
          if best_hand.nil? || HAND_STRENGTH[hand_strength] > HAND_STRENGTH[best_hand]
            best_hand = hand_strength
            winning_player = player
          elsif HAND_STRENGTH[hand_strength] == HAND_STRENGTH[best_hand]
            if player.hand.highest_card > winning_player.hand.highest_card
              winning_player = player
            end
          end
        end
    
        if winning_player
          puts "#{winning_player.name} wins with a #{best_hand.to_s.gsub('_', ' ')}!"
        else
          puts "It's a draw!"
        end
    end
  end

  def start_game
    puts "How many players are playing?"
    number_of_players = gets.chomp.to_i
    
    player_names = []
    number_of_players.times do |n|
      puts "Enter player #{n+1} name:"
      name = gets.chomp
      player_names << name
    end
  
    game = Game.new(player_names)
    game.play_round
  end
  
  start_game
  
  