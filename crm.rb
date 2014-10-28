# Requiring that the sinatra server to be running
require 'sinatra'

# if you go to http://localhost:4567/ you'll get "Main Menu"
get '/' do
  "Main Menu"
end