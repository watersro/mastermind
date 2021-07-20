# frozen_string_literal: true

require_relative 'player_breaks'
require_relative 'player_makes'
require_relative 'helpers'

module Mastermind
  # game class
  class Game
    attr_accessor :rounds_won, :rounds_lost

    def initialize
      @rounds_won = 0
      @rounds_lost = 0
    end

    def choose_mode
      puts "Press:\n1 to be the Breaker\n2 to be the Maker\n3 to quit"
      choice = gets.chomp.to_i
      choices_statement(choice)
    end

    def choices_statement(choice)
      case choice
      when 1
        chose_one
      when 2
        chose_two
      when 3
        puts "\nTake it easy!"
      else
        puts "Huh, I'm not sure what you mean."
        choose_mode
      end
    end

    def chose_one
      mode = Player.new
      if mode.player_breaks? == true
        @rounds_won += 1
      else
        @rounds_lost += 1
      end
      puts "\nGames won: #{rounds_won}\nGames lost: #{rounds_lost}\n"
      puts "\nPlay again?"
      choose_mode
    end

    def chose_two
      mode = Computer.new
      if mode.computer_breaks?
        @rounds_won += 1
      else
        @rounds_lost += 1
      end
      puts "\nGames won: #{rounds_won}\nGames lost: #{rounds_lost}"
      puts "\nPlay again?"
      puts "\n"
      choose_mode
    end
  end
end
tesl = Mastermind::Game.new

puts tesl.choose_mode

# play

# if play == 1
#   call player-breaks
# elsif play == 2
#   call player-makes
# end

# play again? 1 == player_makes, 2 == player_breaks, 3 == quit
# games won & loss counter
