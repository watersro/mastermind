# frozen_string_literal: true

require_relative 'helpers'

module Mastermind
  # player makes the code
  class Computer
    include HelperMod
    attr_reader :code

    attr_accessor :rounds, :win, :loss, :number_pool, :last_guess, :next_guess

    def initialize
      @code = nil
      @rounds = 1
      @win = 0
      @loss = 0
      @number_pool = %w[1 2 3 4 5 6]
      @last_guess = nil
      @next_guess = %w[x x x x]
    end

    def computer_breaks?
      puts "\nPlease choose a 4 digit code, using numbers 1-6"
      @code = Helpers.new.player_input
      while rounds < 13 && @win.zero? && @loss.zero?
        guess = guess_logic
        puts "\n\nRound: #{rounds} \n\nComputer guesses the code : #{guess}"
        code_guessed?(guess, code)
        round_increment
      end
      Helpers.new.game_won?
    end

    def guess_logic
      if @rounds == 1
        @last_guess = @number_pool.sample(4).join.to_i
      else
        guess_logic_helper
      end
      @last_guess
    end

    def guess_logic_helper
      computer_breaks_code
      @next_guess.each_with_index do |_value, index|
        @next_guess[index] = @number_pool.sample if next_guess[index] == 'x'
      end
      @last_guess = @next_guess.join.to_i
    end

    def computer_breaks_code
      guess_array = @last_guess.to_s.split('')
      code_array = @code.to_s.split('')
      if @last_guess == @code
        @last_guess
      else
        computer_breaks_code_helper(guess_array, code_array)
      end
    end

    def computer_breaks_code_helper(guess_array, code_array)
      guess_array.each_with_index do |value, index|
        if code_array.include?(value) && code_array[index] == guess_array[index]
          # keep value at index
          @next_guess[index] = guess_array[index]
        elsif code_array.include?(value) && code_array[index] != guess_array[index]
          # set value at index to zero
          @next_guess[index] = 'x'
        elsif !code_array.include?(value)
          # remove digit from eligble guesses
          @number_pool.delete(value)
          next_guess[index] = 'x'
        end
      end
    end

    def round_increment
      return unless rounds < 12

      @rounds += 1
      sleeper
    end

    def sleeper
      sleep 3.5
      print "\nThe Computer thinks"
      sleep 0.5
      print '.'
      sleep 0.5
      print '.'
      sleep 0.5
      print '.'
      sleep 1
    end

    def code_guessed?(guess, code)
      if guess.to_i == code.to_i
        @rounds = 14
        puts 'You Lose!'
        @loss += 1
      elsif rounds == 12 && guess.to_i != code.to_i
        puts 'You win!'
        @win += 1
      else
        Helpers.new.accurate(guess, code)
      end
    end
  end
end
