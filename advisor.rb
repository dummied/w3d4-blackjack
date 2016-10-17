class Advisor

attr_accessor :dealer_showing,
              :output

  def initialize(dealer)
    self.dealer_showing = dealer.dealer_show
    game_state
  end

  def dealer_show
    Game.dealer_show
  end

  def game_state
    if dealer_show.length == 1 && dealer_show.include?(value == 11)
      self.output = "Because I'm made of code, I can tell you with a degree of certainty that he's not hiding a Blackjack in ther. But it's still not looking great for you."
    elsif dealer_show.length == 1 && dealer_show.include?(value == 10)
      self.output = "It's your lucky day! Not in this game, though. Definitely not that."
    elsif dealer_show.length == 1 && dealer_show.include?(value == 7..9)
      self.output = "This isn't the worst thing that could happen have happened to you today. Really. I won't bother you with the actuarial tables, but you should worry more."
    elsif dealer_show.length == 1 && dealer_show.include?(value == 4..6)
      self.output = "If you like your hand, you would be wise to double down here, but my creator couldn't be bothered to build that feature."
    elsif dealer_show.length == 1 && dealer_show.include?(value == 3)
      self.output = "If you're under 12, you should take the hit. See? I can give a straight answer. While we're being honest, burn that hat. You know which one."
    elsif dealer_show.length == 1 && dealer_show.include?(value ==2)
      self.output = "The world is your oyster. But you're _probably_ alergic. Proceed at your own risk."
    elsif dealer_show.length >= 2
      self.output = "Oh, now you want my help? Here's a hint: ask before you get yourself into this mess, next time."
    else
      self.output = "How did you get here? Please leave."
    end
  end
end
