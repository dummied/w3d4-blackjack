
class Card

include Comparable

  attr_accessor :suit, :face, :value, :name

  def initialize(suit, face)
    self.suit = suit
    self.face = face
    if %w(J Q K).include? face
      self.value = 10
    elsif face == "A"
      self.value = 11
    else
      self.value = face.to_i
    end
  end

  def self.suits
    %w(spades clubs hearts diamonds)
  end

  def self.faces
    %w(2 3 4 5 6 7 8 9 10 J Q K A)
  end

  def <=>(other)
    value <=> other.value
  end

  def to_s
    "the #{face} of #{suit}"
  end

  def coerce(other)
    [self.value, other]
  end

  def +(card)
    self.value + card.value
  end
end
