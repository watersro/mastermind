# frozen_string_literal: true

require_relative 'helpers'

module Mastermind
  # player breaks the code
  class Player
    include HelperMod
    attr_reader :code

    attr_accessor :rounds, :win, :loss

    def initialize
      @code = nil
      @rounds = 1
      @win = 0
      @loss = 0
    end

    private

    def code_gen
      [rand(1..6), rand(1..6), rand(1..6), rand(1..6)].join
    end

    public

    def player_breaks?
      code = code_gen
      while rounds < 13 && win.zero? && loss.zero?
        puts "\nRound: #{rounds} \nGuess the code!"
        guess = Helpers.new.player_input
        code_guessed?(guess, code)
        @rounds += 1
      end
      if @win == 1
        true
      elsif @loss == 1
        false
      end
    end

    def code_guessed?(guess, code)
      if guess.to_i == code.to_i
        puts "\nYou Win!"
        @rounds = 14
        @win += 1
      elsif rounds == 12 && guess != code
        puts "\nYou Lose!"
        @loss += 1
      else
        Helpers.new.accurate(guess, code)
      end
    end
  end
end
