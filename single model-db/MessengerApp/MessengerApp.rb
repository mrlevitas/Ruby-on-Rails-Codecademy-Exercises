# Here's how a database fits into the request-response cycle.

# When you type http://localhost:8000/welcome, the browser makes a request for the URL /welcome.
# The request hits the Rails router.
# The router maps the URL to a controller action to handle the request.
# The controller action recieves the request, and asks the model to fetch data from the database.
# The model returns data to the controller action.
# The controller action passes the data on to the view.
# The view renders the page as HTML.
# The controller sends the HTML back to the browser.


$ rails new MessengerApp
$ bundle install

# 1) 
# We need four parts to build a Rails app - a model, a route, a controller, and a view.
# Let's start here by creating a model.

$ rails generate model Message 
	# Rails creates two files:
	# a model file in app/models/message.rb. The model represents a table in the database.
	# a migration file in db/migrate/. Migrations are a way to update the database with a new table,
	# or change an existing table.

# 2)
# Open the migration file in 
# db/migrate/ 
# for the messages table. The name of the migration file starts with the timestamp of when it was created. 
# Inside the change method, add this line 
t.text :content
# so it looks like:

class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
	  t.text :content
      t.timestamps
    end
  end
end

	# change method tells Rails what change to make to the database. 
	# Here it uses the create_table method to create a new table in the database for storing messages.
	# Inside create_table, we added t.text :content. This will create a text column called content in the messages tables.
	# The final line t.timestamps is a Rails command that creates two more columns in the messages table called 
	# created_at and updated_at. These columns are automatically set when a message is created and updated.

# 3) 
# Then in the terminal, run:
$ rake db:migrate
	# command updates the database with the new messages data model.

# 4) 
# Finally, run:
rake db:seed
	# command seeds the database with sample data from db/seeds.rb.

# 5) 
# Generate a controller named Messages
$ rails generate controller Messages

# 6) 
# In the Messages controller (app/controllers/messages_controller.rb), add an index, new, and create action:
class MessagesController < ApplicationController
	def index 
	  @messages = Message.all 
	end

	def new 
	  @message = Message.new 
	end
	  
	def create 
	  @message = Message.new(message_params) 
	  if @message.save 
	    redirect_to '/messages' 
	  else 
	    render 'new' 
	  end 
	end
	  
	private 
	def message_params 
	  params.require(:message).permit(:content) # implicit return
	end
end
 
# 7)
# In the routes file, create a route that maps the URL /messages to the Messages controller's index, create, and new action
# When you visit
# http://localhost:8000/messages/new 
# to create a new message, it triggers the first turn of the request/response cycle:

# 7.1) browser makes a HTTP GET request for the URL /messages/new
get '/messages/new' => 'messages#new'
	# The Rails router maps this URL to the Messages controller's new action. 
	# The new action creates a new Message object @message and passes it on to the view in app/views/messages/new.html.erb (see below)
	# In the view, form_for creates a form with the fields of the @message object.

# 7.2) when you fill out the form and press Create, it triggers the second turn of the request/response cycle:
post '/messages' => 'messages#create'
# browser sends the data to the Rails app via an HTTP POST request to the URL /messages.
# This time, the Rails router maps this URL to the create action.
# The create action uses the message_params method to safely collect data from the form and update the database.
get '/messages' => 'messages#index'



# Rails provides seven standard controller actions for doing common operations with data. 
# Here we want display a list of all messages, so we used the index action.

# 8)
# Open app/views/messages/index.html.erb
# The default web templating language in Rails is embedded Ruby, or ERB.
<div class="header">
  <div class="container">
    <img src="http://s3.amazonaws.com/codecademy-content/courses/learn-rails/img/logo-1m.svg">
    <h1>Messenger</h1>
  </div>
</div>

<div class="messages">
  <div class="container">
  
# added this
<% @messages.each do |message| %> 
<%= link_to 'New Message', "messages/new" %> # link_to creates a link to /messages/new instead of hardcoding <a> elements: 1st param is link text, 2nd param is the URL
<div class="message"> 
  <p class="content"><%= message.content %></p> 
  <p class="time"><%= message.created_at %></p> 
</div> 
<% end %>

  </div>
</div>


# 9)
# in app/views/messages/new.html.erb:
<div class="header">
  <div class="container">
    <img src="http://s3.amazonaws.com/codecademy-content/courses/learn-rails/img/logo-1m.svg">
    <h1>Messenger</h1>
  </div>
</div>

<div class="create">
  <div class="container">
    
# added this
  <%= form_for(@message) do |f| %>  
  <div class="field"> 
    <%= f.label :message %><br> 
    <%= f.text_area :content %> 
  </div> 
  <div class="actions"> 
    <%= f.submit "Create" %> 
  </div> 
<% end %>
        
  </div>
</div>
