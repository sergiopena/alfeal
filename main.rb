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

def index(person, number)
  this_is_ugly = [
    [1, 2, 2],
    [3, 5, 7],
    [4, 6, 8],
    [9, 11, 13],
    [10, 12, 14]
  ]
  this_is_ugly[person][number]
end

# Base class
class Elfeal < Sinatra::Base
  set :bind, '0.0.0.0'
  set :logging, true
  set :dump_errors, true
  set :timeout, 60
  set :raise_errors, true

  enable :sessions

  get '/' do
    load_config

    # Get random tense
    tense = rand(@opt['tense'].length)
    @tense = @opt['tense'][tense]['s']

    # Get random person, only second for imperative
    person = if tense == 4
               rand(1..2)
             else
               rand(@opt['person'].length)
             end
    @person = @opt['person'][person]

    # Get random number
    number = rand(@opt['number'].length)
    @number = @opt['number'][number]

    # Get random verb
    verb = @opt['verb'].sample
    @verb = verb['s']

    out_file = File.new(session.id, 'w')
    out_file.puts(verb['q'].split('-').join("\t"))
    out_file.close

    conjugado = ` ./lib/conjugate.py -f #{session.id} -#{@opt['tense'][tense]['q']} `
    line = conjugado.split("\n")[index(person, number) + 5]
    @resultado = if @opt['tense'][tense]['q'] != 'm'
                   line
                 elsif @opt['tense'][tense]['tag'] == 'mansoub'
                   line = line.split("\t")
                   line.delete_at(2)
                   line.join(' ')
                 else
                   line = line.split("\t")
                   line.delete_at(1)
                   line.join(' ')
                 end
    File.delete(session.id)
    erb :index
  end
end

Elfeal.run!
#binding.pry

#puts "a"
