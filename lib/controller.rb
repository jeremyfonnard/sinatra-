require 'bundler'
Bundler.require
require './lib/gossip'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: { gossips: Gossip.all }
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  
  # Route pour afficher un seul potin
  get '/gossips/:id/' do
    gossip = Gossip.find(params['id'])
    erb :show, locals: { gossip: gossip }
  end

  
  # Route pour crée un potin
  get '/gossips/:id/edit/' do
    gossip = Gossip.find(params['id'])
    erb :edit, locals: { gossip: gossip }
  end

# Met à jour un potin existant avec les nouvelles valeurs et redirige vers la page d'accueil  
  post '/gossips/:id/edit/' do
    gossip = Gossip.find(params['id'])
    gossip.author = params["gossip_author"]
    gossip.content = params["gossip_content"]
    gossip.save
    redirect '/'
  end
end

get '/' do
    erb :index, locals: { gossips: Gossip.all }
  end
  