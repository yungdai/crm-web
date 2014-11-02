# Require sinatra gem
require_relative 'contacts'
require 'sinatra'

# get '/' do
#   "Hello World!"
# end

# get '/contacts' do
#   erb: contacts
# end

get "/" do
  # go inside the views folder for index.html
  erb :index
end

# get '/contacts' do
#   @contacts = []
#   @contacts << Contact.new("Yung", "Dai", "yungchidai@gmail.com", "This is Yung Dai")
# end



#
# post '/contact' doputs "PARAMS: #{params}"
# contact = Contact.new(params[:first_name], params [:last_name], params[:email], params[:note])