module Mastermind
  
  class CodeParser
    def parse(input)
      parse_input = []
      
      input.split.each do |num|
        parse_input << num.to_i if num =~ /\d/
      end
      
      parse_input.size > 0 ? parse_input : nil
    end
  end
  
end