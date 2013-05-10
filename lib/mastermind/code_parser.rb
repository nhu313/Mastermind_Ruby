require 'mastermind/code'

module Mastermind
  
  NONDIGIT_OR_NONWHITESPACE = /[^\d^\s]/
  
  class CodeParser
    def parse(input)
      return nil if input.strip.empty?
      return nil if input.match(NONDIGIT_OR_NONWHITESPACE)
      Mastermind::Code.new(input.split.map(&:to_i))
    end
  end
  
end