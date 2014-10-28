
# Require sinatra gem
require 'sinatra'


get "/" do
  # go inside the views folder for index.html
  html :index
end
# get "/" do
#   puts "PARAMS #{params.inspect}"
# end


# Going to localhost:4567/<whatever> brings up the get code
get "/hi" do
  "Hi!!!"
end


# look into the ./views/ folder and find the people.erb file
# do http://localhost:4567/people/<person's name you want it to say hi
get "/people/:name" do
  @name = params[:name]
  erb :people
end
#
# get "/chris" do
#   "Hi Chris!"
# end
#
# get "/maria" do
#   "Hi Maria!"
# end

# this takes anything after the / and outputs "Hi <name> !"
# Whenever you want to use a wildcard always use a colon (:) example: :name is a wildcard with the variable named name
# get "/:name" do
#   puts "PARAMS #{params.inspect}"
#   name = params[:name]
#   "Hi #{name.capitalize}!"
# end