require_relative "deck"
require "pry"


class BlackJack

  attr_accessor :dealer,
                :player,
                :deck

  def initialize
    puts "Let's play a game of Black Jack."
    self.deck = Deck.new
    self.dealer = []
    self.player = []
    self.deck.shuffle!
  end

  def play_hand
    deal_hand
    reveal_cards
    player_turn
    dealer_turn
    score_hand
  end

  def deal_hand
    2.times do
      self.dealer << deck.deal
      self.player << deck.deal
    end
  end

  def reveal_cards
    puts "Dealer showing #{hand_simplified(dealer.drop(1))}"
    puts "Player has #{hand_simplified(player)}"
  end

  def player_turn
    catch (:stand) do
      until bust?(player, "Player") || blackjack?(player, "Player")
        hit_choice
      end
    end
  end

  def dealer_turn
    until bust?(dealer, "Dealer") || blackjack?(dealer, "Dealer")
      while dealer_hit?
        dealer_hit
      end
    end
  end

  def bust?(hand, who)
    if hand.inject(:+) <= 21
      false
    else
      puts "#{who} has busted with #{hand_simplified(hand)}."
      if who == "dealer"; puts "Player wins!" else puts "Dealer wins!" end
      play_again
      true
    end
  end

  def blackjack?(hand, who)
    if hand.inject(:+) == 21 && hand.length == 2
      puts "#{who} won with a Black Jack!"
      play_again
      true
    else
      false
    end
  end

  def dealer_hit?
    dealer.inject(:+) <= 16
  end

  def dealer_hit
    puts "Dealer will hit."
    self.dealer << deck.deal
    reveal_cards
    dealer_turn
  end

  def hit_choice
    puts "Would you like another card ('hit'), or to keep your current hand ('stand')?"
    response = gets.chomp.downcase
    if response == "hit"
      player_hit
    elsif response == "stand"
      puts "The player will stand with #{hand_simplified(player)}"
      throw :stand
    else
      puts "It\'s not that kind of game."
      hit_choice
    end
  end

  def player_hit
    puts "Player will hit."
    self.player << deck.deal
    reveal_cards
  end

  def hand_strength(hand)
    hand.inject(:+)
  end

  def hand_simplified(hand)
    hand = hand.collect
    hand.each { |card| card.to_s }.join(", ")
  end

  def score_hand
    if hand_strength(dealer) > hand_strength(player)
      puts "Dealer wins with #{hand_simplified(dealer)}. Player had #{hand_simplified(player)}"
    elsif hand_strength(dealer) < hand_strength(player)
      puts "Player wins with #{hand_simplified(player)}. Dealer had #{hand_simplified(dealer)}"
    else
      puts "We have a tie. Dealer had #{hand_simplified(dealer)}. Player had #{hand_simplified(player)}"
    end
  end

  def play_again
    puts "Would you like to play again? (y/n)"
    response = gets.chomp.downcase
    if response == "y"
      initialize
      play_hand
    else
      puts "Thanks for playing"
      exit
    end
  end

end

binding.pry
