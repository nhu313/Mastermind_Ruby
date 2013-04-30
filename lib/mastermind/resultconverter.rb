module Mastermind
  
  class ResultConverter
    def to_string(results)
      results_chars = ["b", "w"]
      results_string = String.new
      
      results_chars.each_with_index do |value, value_index|
        value_count = results[value_index] 
        1.upto(value_count).each do |i|
          results_string += value
          results_string += " " if i < value_count
        end
        
        results_string += " " if (results_string.size > 0)
      end
      
      results_string = results_string.strip
      
      "[#{results_string}]"
    end
  end
  
end