require_relative "card"

class Deck

  attr_accessor :box

  def initialize
    self.box = []
    Card.suits.each do |suit|
      Card.faces.each do |face|
        box << Card.new(suit, face)
      end
    end
  end

  def shuffle!
    box.shuffle!
  end

  def deal
    box.shift
  end

  def empty?
    box.empty?
  end

end
