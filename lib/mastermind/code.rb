module Mastermind
  Result = Struct.new(:exact_match, :incorrect_position_match, :no_match)
  
  class Code
    attr_reader :value
    
    private
    attr_writer :value
    
    public
    def initialize(code_value)
      @value = code_value
    end

    def results(guess)
      exact_match = count_exact_match(guess)
      incorrect_position_match = count_incorrect_position_match(guess)
      no_match = size - (exact_match + incorrect_position_match)
      Result.new(exact_match, incorrect_position_match, no_match)
    end
    
    def count_exact_match(guess)
      guess_value = guess.value
      number_of_exact_match = 0
      value.each_with_index do |peg, i|
        number_of_exact_match += 1 if peg == guess_value[i] 
      end
      number_of_exact_match
    end
    
    def count_incorrect_position_match(guess)
      number_of_position_match = 0
      guess_value = guess.value
      
      matches = value & guess_value
      matches.each do |peg|
        secret_code_count = value.count(peg)
        guess_count = guess_value.count(peg)
        number_of_position_match += [secret_code_count, guess_count].min
      end
      
      incorrect_position_match = number_of_position_match - count_exact_match(guess)
    end
    
    def size
      value.size
    end
    
    def to_s
      value.to_s
    end
  end  
end