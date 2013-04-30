module Mastermind
  Result = Struct.new(:exact_match, :incorrect_position_match, :no_match)
  
  class Code
    attr_reader :secret_code
    attr_accessor :code_generator, :size
    
    def initialize(size, code_generator=Mastermind::CodeGenerator.new)
      @size = size
      @code_generator = code_generator
      new_code
    end
    
    def new_code
      @secret_code = code_generator.random_code(size)
    end

    def results(guess)
      exact_match = count_exact_match(guess)
      incorrect_position_match = count_incorrect_position_match(guess)
      no_match = secret_code.size - (exact_match + incorrect_position_match)
      Result.new(exact_match, incorrect_position_match, no_match)
    end
    
    def count_exact_match(guess)
      number_of_exact_match = 0
      secret_code.each_with_index do |peg, i|
        number_of_exact_match += 1 if peg == guess[i] 
      end
      number_of_exact_match
    end
    
    def count_incorrect_position_match(guess)
      number_of_position_match = 0
      
      matches = secret_code & guess
      matches.each do |peg|
        secret_code_count = secret_code.count(peg)
        guess_count = guess.count(peg)
        number_of_position_match += [secret_code_count, guess_count].min
      end
      
      incorrect_position_match = number_of_position_match - count_exact_match(guess)
    end
    
  end  
end