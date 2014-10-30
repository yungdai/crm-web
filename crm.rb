# include Contact class into the crm.rb program
require_relative 'contacts'
# include the Rolodex class into the crm.rb program
require_relative 'rolodex'
@@rolodex = Rolodex.new

# Temporary fake data so that we always find contact with id 1000.
@@rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com", "Rockstar"))
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
  @crm_app_name = "My Bitmaker CRM"
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

# creating a new rout that is /contacts/1000 to show what is in the @@rolodex.contact_id(1000)
get "/contacts/1000" do
  @contact = @@rolodex.find(1000)
  erb :show_contact
end

# new code to edit a contact
get "/contacts/edit/:id" do
  id = params[:id].to_i
  puts params
  contact_to_edit = $rolodex.find_contact(id)[0]
  puts contact_to_edit
  $rolodex.set_contact(contact_to_edit)
  erb :edit_contact
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

