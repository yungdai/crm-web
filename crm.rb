# include Contact class into the crm.rb program
require_relative 'contacts'
# Requiring that the sinatra server to be running
require 'sinatra'

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
# "/contacts" route with some fake data using the contacts object Inside crm.rb, create some fake data inside an array
get "/contacts" do
  @contacts = []
  @contacts << Contact.new("Julie", "Hache", "julie@bitmakerlabs.com", "Instructor")
  @contacts << Contact.new("Will", "Richman", "will@bitmakerlabs.com", "Co-Founder")
  @contacts << Contact.new("Chris", "Johnston", "chris@bitmakerlabs.com", "Instructor")
  erb :contacts
end