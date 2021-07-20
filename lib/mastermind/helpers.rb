# frozen_string_literal: true

module HelperMod
  # Helper methods for both modes
  class Helpers
    attr_accessor :win, :loss

    def game_won?
      if win == 1
        true
      elsif loss == 1
        false
      end
    end

    def player_input
      input = gets.chomp
      if input.length != 4
        puts 'Must only be 4 digits between 1-6'
        player_input
      elsif input.match?(/[^1-6]/)
        puts 'Must only be 4 digits between 1-6'
        player_input
      else
        input
      end
    end

    def accurate(guess, code)
      guess_array = guess.to_s.split('')
      code_array = code.to_s.split('')
      exact = code_exact(guess_array, code_array)
      similar = code_similar(guess_array, code_array)
      display_clues(exact, similar)
    end

    def code_exact(guess_array, code_array)
      exact = 0
      guess_array.each_with_index do |value, index|
        next unless code_array.include?(value)

        if code_array[index] == guess_array[index]
          remove = code_array.find_index(guess_array[index])
          code_array[remove] = nil && guess_array[index] = nil
          exact += 1
        end
      end
      exact
    end

    def code_similar(guess_array, code_array)
      similar = 0
      guess_array.each_with_index do |value, index|
        next unless code_array.include?(value)

        if code_array[index] != guess_array[index]
          remove = code_array.find_index(guess_array[index])
          code_array[remove] = nil && guess_array[index] = nil
          similar += 1
        end
      end
      similar
    end

    def display_clues(exact, similar)
      puts "\n#{exact} are in the correct position\n#{similar} are the right numbers in the wrong position"
    end
  end
end
