module Mastermind

  class CodeGenerator
    
    def random_code(size)
      code = []
      (0...size).each do
        code << random_number
      end
      code
    end
    
    def random_number
      rand(10)
    end
    
  end

end