$:.unshift File.dirname(__FILE__) + '/lib'

require 'rubygems'
require 'bundler'

Bundler.setup

require 'alfeal'

Alfeal.setup

run Alfeal::API
