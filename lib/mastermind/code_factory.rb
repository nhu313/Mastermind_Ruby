require 'mastermind/code'

module Mastermind

  class CodeFactory
    
    def random_code(size)
      code = []
      (0...size).each do
        code << random_number
      end
      
      Mastermind::Code.new(code)
    end
    
    def random_number
      rand(10)
    end
    
  end

end