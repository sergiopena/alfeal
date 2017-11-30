#!/usr/bin/env ruby

require 'pry'
require 'sinatra'
require 'yaml'

def load_config
  # Holds all possible options to conjugate
  @opt = YAML.load_file(__dir__ + '/config/config.yml')
rescue StandardError => e
  puts e
end

def spin_roulette


# Base class
class Elfeal < Sinatra::Base
  set :bind, '0.0.0.0'
  set :logging, true
  set :dump_errors, true
  set :timeout, 60
  set :raise_errors, true

  get '/' do
    load_config
    tense = rand(@opt['tense'].length)
    @tense = @opt['tense'][tense]
    person = if tense == 4
               rand(1..2)
             else
               rand(@opt['person'].length)
             end
    @person = @opt['person'][person]
    number = rand(@opt['number'].length)
    @number = @opt['number'][number]
    verb = @opt['verb'].sample
    @verb = verb['s']
    out_file = File.new('out', 'w')
    out_file.puts(verb['q'].split('-').join("\t"))
    out_file.close

    binding.pry

    erb :index
  end
end

 Elfeal.run!
load_config
verb = @opt['verb'].sample
out_file = File.new('out', 'w')
out_file.puts(verb['q'].split('-').join("\t"))
out_file.close
binding.pry
puts 'a'
