# include Contact class into the crm.rb program
require_relative 'contacts'
# include the Rolodex class into the crm.rb program
require_relative 'rolodex'
# Requiring that the sinatra server to be running
require 'sinatra'

# In order to have access to the Rolodex from each action in Sinatra, you'll need to create a class variable before all your routes.
$rolodex = Rolodex.new

# if you go to http://localhost:4567/ you'll get "Main Menu"
# get '/' do
#   "Main Menu"
# end

# if you go to http://localhost:4567/ it will open the ./views/index.erb file
# get '/' do
#   erb :index
# end

# adding some ruby code into the crm.rb program
# setting up an instance variable @crm_app_name that we'll be able to pass this value along to our view.
get '/' do
  @crm_app_name = "My CRM"
  erb :index
end

# new GET request to /view/contacts.erb file
get "/contacts" do
  erb :contacts
end