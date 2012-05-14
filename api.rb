require 'sinatra'
require 'json'
require 'mongoid'

require './mongoconfig'
require './models'

class API < Sinatra::Base

  get '/user.json' do
    content_type :json

    users = User.all

    users.to_json
  end

  post '/user' do

=begin
    User.create! :firstName => 'Homer', :lastName => 'Simpson'
    User.create! :firstName => 'Marge', :lastName => 'Simpson', :devices => [{:name => "iPhone"}]
=end

    user = JSON.parse(request.body.read)
    newUser = User.create(user)

    newUser.save
    newUser.to_json

  end

  get '/sass_css/:name.css' do
    content_type 'text/css', :charset => 'utf-8'
    scss(:"/stylesheets/#{params[:name]}")
  end

  get '/' do
    erb :index
  end
end
