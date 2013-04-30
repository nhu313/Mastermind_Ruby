$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'mastermind/controller'

game = Mastermind::Controller.new
game.start_game