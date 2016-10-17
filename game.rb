require_relative "deck"
# require_relative "advisor"
require "pry"


class BlackJack

  attr_accessor :dealer,
                :player,
                # :advisor,
                :dealer_score,
                :player_score,
                :game_counter,
                :deck,
                :shoe

  # def self.dealer_show
  #   dealer.hand_simplified.drop(1)
  # end

  def initialize
    puts "Let's play a game of Black Jack."
    self.deck = Deck.new
    self.shoe = []
    7.times do self.shoe = deck end
    self.dealer = []
    self.player = []
    self.shoe.shuffle!
    self.dealer_score = 0
    self.player_score = 0
    self.game_counter = 0
  end

  def play_hand
    self.game_counter += 1
    deal_hand
    reveal_cards
    blackjack(dealer, "Dealer") if blackjack?(dealer)
    player_turn
    dealer_turn
    score_hand
  end

  def continue
    self.dealer = []
    self.player = []
    play_hand
  end

  # def advice
  #   self.advisor = Advisor.new(player, dealer)
  #   puts advisor.output
  # end

# Game Mechanics

  def deal_hand
    2.times do
      self.dealer << shoe.deal
      self.player << shoe.deal
    end
  end

  def reveal_cards
    puts "Dealer showing #{hand_simplified(dealer.drop(1))}"
    puts "Player has #{hand_simplified(player)}"
  end

# Player Logic

  def player_turn
    blackjack(player "Player") if blackjack?(player)
    player_ace(player)
    busted(player, "Player") if bust?(player)
    hit_choice
  end

  def hit_choice
    puts "Would you like another card ('hit'), or to keep your current hand ('stand')?"
    # puts "Press 'i' for a hint."
    response = gets.chomp.downcase
    if response == "hit"
      player_hit
    elsif response == "stand"
      player_stand
    # elsif response == "i"
    #   advice
    else
      puts "It\'s not that kind of game."
    end
    player_turn
  end

  def player_hit
    puts "Player will hit."
    self.player << shoe.deal
    reveal_cards
    player_turn
  end

  def player_stand
    puts "The player will stand with #{hand_simplified(player)}"
    busted(player, "Player") if bust?(player)
    blackjack(player "Player") if blackjack?(player)
    dealer_turn
  end

  def player_ace(player)
    player.each do |card|
      if card.face == "A"
        puts "Would you like this Ace to be worth 1 or 11?"
        response = gets.chomp
        if response == 1
          card.value = 1
        else
          card.value = 11
        end
      end
    end
    hit_choice
  end

# Dealer Logic

  def dealer_turn
    dealer_ace(dealer)
    busted(dealer, "Dealer") if bust?(dealer)
    blackjack(dealer, "Dealer") if blackjack?(dealer)
    dealer_hit if dealer_hit?
    dealer_stand
  end

  def dealer_hit?
    if dealer.inject(:+) <= 16
      true
    else
      false
    end
  end

  def dealer_hit
    puts "Dealer will hit."
    self.dealer << shoe.deal
    reveal_cards
    dealer_turn
  end

  def dealer_stand
    puts "Dealer will stand."
    score_hand
  end

  def dealer_ace(dealer)
    dealer.each do |card|
      while card.face == "A" && dealer.inject(:+) >= 15
        card.value = 1
      end
    end
  end

# Conditionals

  def blackjack?(hand)
    if hand.inject(:+) == 21 && hand.length == 2
      true
    else
      false
    end
  end

  def blackjack(hand, who)
    score_win(who)
    puts "#{who} won with a Black Jack!"
    puts "Dealer had #{hand_simplified(dealer)}. Player had #{hand_simplified(player)}."
    play_again
  end

  def bust?(hand)
    if hand.inject(:+) >= 22
      true
    else
      false
    end
  end

  def busted(hand, who)
    puts "#{who} has busted with #{hand_simplified(hand)}."
    score_loss(who)
    if who == "Dealer"; puts "Player wins!" else puts "Dealer wins!" end
    play_again
  end

  def three_legged_rabbit?(hand)
    if hand.length >= 6
      true
    else
      false
    end
  end

  def lucky(hand, who)
    puts "Six card hand wins!"
    score_win(who)
  end

# Score/Win Logic

  def dealer_win
    puts "Dealer wins with #{hand_simplified(dealer)}. Player had #{hand_simplified(player)}"
  end

  def player_win
    puts "Player wins with #{hand_simplified(player)}. Dealer had #{hand_simplified(dealer)}"
  end

  def score_hand
    if hand_strength(dealer) > hand_strength(player)
      dealer_win
    elsif hand_strength(dealer) < hand_strength(player)
      player_win
    else
      puts "Tie score, higher hand count wins."
      if player.length >= dealer.length
        player_win
      else
        dealer_win
      end
    end
    play_again
  end

  def score_loss(who)
    if who == "Dealer"
      self.player_score += 1
    else
      self.dealer_score += 1
    end
    play_again
  end

  def score_win(who)
    if who == "Dealer"
      self.dealer_score += 1
    else
      self.player_score += 1
    end
      play_again
  end

  def play_again
    puts "Would you like to play again? (y/n)"
    response = gets.chomp.downcase
    if response == "y"
      continue
    else
      if player_score >= 2*dealer_score
        puts "We have some questions for you. This way please."
      elsif player_score >= dealer_score
        puts "Well done."
      elsif 2*player_score < dealer_score
        puts "You're technically property of the casino, now."
      else
        puts "Come back soon!"
      end
      puts "Thanks for playing. You won #{player_score} games. The house won #{dealer_score} games."
      exit
    end
  end

# Data Manipulators

  def hand_strength(hand)
    hand.inject(:+)
  end

  def hand_simplified(hand)
    hand.collect { |card| card.to_s }.join(", ")
  end

end

binding.pry
