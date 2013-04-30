$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'mastermind/controller'

NUMBER_OF_GUESSES = 3

game = Mastermind::Controller.new
game.start_game