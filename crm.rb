# include Contact class into the crm.rb program
require_relative 'contacts'
# include the Rolodex class into the crm.rb program
require_relative 'rolodex'


# # Temporary fake data so that we always find contact with id 1000.  Uncomment to use
# @@rolodex = Rolodex.new
# @@rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com", "Rockstar"))
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

# creating a new route that is /contacts/<id#>
get "/contacts/:id" do
  #this will look at the address bar and see that at at /contacts/<contact_id # = :id>
  @contact = $rolodex.find(params[:id].to_i)

  # if @contact comes back as found then run the show_contact.erb file.  If it's not found then tell Sinatra that the
  # page is not found
  if @contact
    erb :show_contact
  else
    erb :not_found
  end
end


# create a new route that is /contatcs/<id#>/edit
get "/contacts/edit/:id" do
  @contact = $rolodex.find(params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    erb :not_found
  end
end

# if the Sinatra gets a put request it will get it for the /contacts/<id#>
# Let's look at this new route step-by-step:
# # This route handles a "put" request about a particular id. Inside the block params will contain the id along with any
# of information we submitted in the form.
# # With the id from the params, we start by finding the contact. If there's ever any reason we don't find it, we raise
# "Not Found".
# # If the contact is found, we need to update it. Once it's updated, we want to redirect to our main contacts page.
put "/contacts/:id" do
@contact = $rolodex.find(params[:id].to_i)
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.note = params[:note]
    redirect to("/contacts")
  else
    erb :not_found
  end
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

# delete a contact
delete "/contacts/:id" do
  @contact = $rolodex.find(params[:id].to_i)
    if @contact
      $rolodex.remove_contact(@contact)
      redirect to("/contacts")
    else
      erb :not_found
    end
end

