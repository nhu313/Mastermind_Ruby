# :unshift File.expand_path('../lib', __FILE__)

begin
  require 'simplecov'
  SimpleCov.start do
    add_filter "/spec/"
  end

rescue LoadError
  puts 'Coverage disabled, enable by installing simplecov'
end

require 'mastermind/code'
require 'mastermind/code_factory'
require 'mastermind/code_parser'
require 'mastermind/controller'
require 'mastermind/game'
require 'mastermind/result_converter'
require 'mastermind/console'
