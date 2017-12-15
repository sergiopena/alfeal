require 'sinatra/base'
require 'byebug'
require_relative '../alfeal.rb'

module Alfeal
  class API < Sinatra::Base
    set :bind, '0.0.0.0'
    set :logging, true
    set :dump_errors, true
    set :timeout, 60
    set :raise_errors, true
    set :views, File.join(File.dirname(__FILE__), '../../views')

    enable :sessions

    get '/' do
      @opt = Alfeal.config

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

      conjugado = `./lib/qutrub/conjugate.py -f #{session.id} -#{@opt['tense'][tense]['q']}`
      line = conjugado.split("\n")[Alfeal.index(person, number) + 5]
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
end
