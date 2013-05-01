$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'mastermind/controller'

code = Mastermind::Code.new([1])
code2 = Mastermind::Code.new([2])
puts(code == code2)

game = Mastermind::Controller.new
game.start_game