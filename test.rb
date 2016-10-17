require_relative "game"
require 'minitest/autorun'
require 'minitest/pride'

class CardTest < MiniTest::Test

  def test_aces_worth_eleven
    card = Card.new("Diamonds", "A")
    assert_equal 11, card.value
  end

  def test_face_cards_worth_10
    card = Card.new("Diamonds", "K")
    assert_equal 10, card.value
  end

  def test_cards_can_be_added
    card = Card.new("Diamonds", "K")
    card2 = Card.new("Diamonds", "A")
    assert_equal 21, card + card2
  end

  def test_card_to_s
    card = Card.new("Diamonds", "K")
    assert_equal "the K of Diamonds", card.to_s
  end

  def test_cards_can_be_added_to_numbers
    card = Card.new("Diamonds", "K")
    assert_equal 12, 2 + card
  end

end

class DeckTest < MiniTest::Test

  def test_a_deck_is_shuffled_at_the_start
    deck = Deck.new
    assert deck.box.length == 52
    deck2 = Deck.new
    refute deck.box == deck2.box
  end

  def test_deals_a_card
    deck = Deck.new
    deal = deck.deal
    assert deal.is_a? Card
  end

end

class BlackJackTest < MiniTest::Test

  def test_blackjack_method_true
    game = BlackJack.new(false)
    hand = [Card.new("Diamonds", "A"), Card.new("Clubs", "J")]
    assert game.blackjack?(hand)
  end

  def test_blackjack_method_false
    game = BlackJack.new(false)
    hand = [Card.new("Diamonds", "10"), Card.new("Clubs", "J")]
    refute game.blackjack?(hand)
  end

  def test_three_cards_arent_blackjack
    game = BlackJack.new(false)
    hand = [Card.new("Diamonds", "9"), Card.new("Diamonds", "2"), Card.new("Clubs", "J")]
    refute game.blackjack?(hand)
  end


end
