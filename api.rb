require 'sinatra'
require 'json'
require 'mongoid'

class API < Sinatra::Base

  # MongoDB configuration
  Mongoid.configure do |config|
    if ENV['MONGOHQ_URL']
      conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
      uri = URI.parse(ENV['MONGOHQ_URL'])
      config.master = conn.db(uri.path.gsub(/^\//, ''))
    else
      config.master = Mongo::Connection.from_uri("mongodb://localhost:27017").db('mongosinatrastarter')
    end
  end

  # Models

  class User
    include Mongoid::Document

    field :firstName
    field :lastName

    #embeds_many :devices
  end

  class Device
    include Mongoid::Document

    field :name
    field :type
    #embedded_in :user, :inverse_of => :devices

  end

  get '/user.json' do
    content_type :json

    users = User.all

    users.to_json
  end

  post '/user' do

    User.create! :firstName => 'Homer', :lastName => 'Simpson'
    User.create! :firstName => 'Marge', :lastName => 'Simpson'
=begin
    user = JSON.parse(request.body.read)
    newUser = Users.create(user)

    newUser.save
    newUser.to_json
=end

  end

  get '/sass_css/:name.css' do
    content_type 'text/css', :charset => 'utf-8'
    scss(:"/stylesheets/#{params[:name]}")
  end

  get '/' do
    erb :index
  end
end
