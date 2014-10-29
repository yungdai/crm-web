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
  @title = "My Bitmaker Web CRM App"
  @crm_app_name = "My CRM"
  erb :index
end

# new GET request to /views/contacts.erb file
get "/contacts" do
  @title = "View All Contacts"
  erb :contacts
end

# as the last route, add for /views/new_contacdt.erb
get '/contacts/new' do
  @title = "Adding New Contacts"
  erb :new_contact
end

# inspect the data submitted by the form
post '/contacts' do
  # puts params # inspect the data submitted by the form and shows the raw data
  # The params hash is available inside any block!!


  # This calls new_contact.erb and creates a new Contact.Object with the keys that Contact.Object Requires
  new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
  $rolodex.add_contact(new_contact)

  # Once a new object is create if should return you to the /views/contacts.erb file
  redirect to('/contacts')
end

