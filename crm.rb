# require_relative 'contacts' has been removed because we're going to use a database now
# include the Rolodex class into the crm.rb program
# require_relative 'rolodex'


# # Temporary fake data so that we always find contact with id 1000.  Uncomment to use
# @@rolodex is a class variable and only accessible inside the class
# @@rolodex = Rolodex.new
# @@rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com", "Rockstar"))
# Requiring that the sinatra server to be running
require 'sinatra'

# requiring DataMapper, it is a database agnostic ORM
require 'data_mapper'
DataMapper.setup(:default, "sqlite3:database.sqlite3")

# moved the Contact Class back into crm.rb
# Transforming the Contact class into a DataMapper resource
class Contact
  #by including the DataMapper::Resource module, we will have access to the special DataMapper methods.
  include DataMapper::Resource
  # new Contact class object
  # no need for this ruby code anymore for
  # attr_accessor :id, :first_name, :last_name, :email, :note
  # because every time we create a new Contact record, it will automatically be interested into the contacts
  # database table.

  # when using using the DataMapper resource
  property :id, Serial # The Serial property represents an Integer that automatically increments
  property :first_name, String
  property :last_name, String
  property :email, String
  property :note, String

end

DataMapper.finalize # validate any issues with the properties or tables we defined.
DataMapper.auto_upgrade! #takes care of effecting any changes to the underlying structure of the tables or columns

# In order to have access to the Rolodex from each action in Sinatra, you'll need to create a class variable before all
# your routes.
# created the global variable called $rolodex, this variable should accessible throughout the entire program.
# No longer required to use Rolodex:  $rolodex = Rolodex.new

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
get '/contacts' do
  @title = "View All Contacts"
  @contacts = Contact.all
  erb :contacts
end

# Add a new contact!  As the last route, add for /views/new_contacdt.erb
get '/contacts/new' do
  @title = "Adding New Contacts"
  erb :new_contact
end

# creating a new route that is /contacts/<id#>
# this get method will go to delete_contract.erb when found
get '/contacts/:id' do
  #this will look at the address bar and see that at at /contacts/<contact_id # = :id>
  @contact = Contact.get(params[:id].to_i)
  # if @contact comes back as found then run the show_contact.erb file.  If it's not found then tell Sinatra that the
  # page is not found
  if @contact
    erb :delete_contact
  else
    erb :not_found
  end
end

# create a new route that is /contacts/<id#>/edit
# this get method is us used to edit a contact
get '/contacts/edit/:id' do
  @contact = Contact.get(params[:id].to_i)
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
put '/contacts/:id' do
@contact = Contact.get(params[:id].to_i)
  if @contact.update(
          :first_name => params[:first_name],
          :last_name => params[:last_name],
          :email => params[:email],
          :note => params[:note]
      )
    redirect to ('/contacts')
  else
    erb :not_found
  end
end

# inspect the data submitted by the form
post '/contacts' do
  # puts params # inspect the data submitted by the form and shows the raw data
  # The params hash is available inside any block!!

  @contact = Contact.create(
      :first_name => params[:first_name],
      :last_name => params[:last_name],
      :email => params[:email],
      :note => params[:note]
  )
  # Once a new object is create if should return you to the /views/contacts.erb file
  redirect to('/contacts')
end



# delete a contact
delete '/contacts/:id' do
  @contact = Contact.get(params[:id].to_i)
    if @contact
      @contact.destroy
      redirect to("/contacts")
    else
      erb :not_found
    end
end

