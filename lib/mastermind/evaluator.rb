module Mastermind
  
  class Evaluator
    
    def count_exact_match(secret_code, guess)
      number_of_exact_match = 0
      secret_code.each_with_index do |code, i|
        number_of_exact_match += 1 if code == guess[i] 
      end
      number_of_exact_match
    end
    
    def count_incorrect_position_match(secret_code, guess)
      number_of_position_match = 0
      
      matches = secret_code & guess
      matches.each do |code|
        secret_code_count = secret_code.count(code)
        guess_count = guess.count(code)
        number_of_position_match += [secret_code_count, guess_count].min
      end
      
      incorrect_position_match = number_of_position_match - count_exact_match(secret_code, guess)
    end

    def evaluate(secret_code, guess)
      exact_match = count_exact_match(secret_code, guess)
      incorrect_position_match = count_incorrect_position_match(secret_code, guess)
      no_match = secret_code.size - exact_match - incorrect_position_match
      [exact_match, incorrect_position_match, no_match]
    end

  end
  
end