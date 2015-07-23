$ rails new innovation-cloud
$ cd innovation-cloud
$ bundle install
$ rails generate model Signup

# Open the migration file in db/migrate/
# add a string column called email

class CreateSignups < ActiveRecord::Migration
  def change
    create_table :signups do |t|
      t.string :email
      t.timestamps
    end
  end
end


$ rake db:migrate

$ rails generate controller Signups
$ rails generate controller Pages

# Pages controller contains action 'thanks'

class PagesController < ApplicationController
	def thanks
	end
end			

# resource route
# It maps URLs to the Signups controller's seven standard actions

resources :signups
get '/thanks' => 'pages#thanks'
root 'signups#new'

$ rake routes



class SignupsController < ApplicationController
	def new
		@signup = Signup.new
	end
  
  def create
	  @signup = Signup.new(signup_params) 
	  if @signup.save 
	    redirect_to '/thanks' 
	  else 
	    render 'new' 
	  end     
  end
  
  private
  
  def signup_params
    params.require(:signup).permit(:email)
  end
end
				

# app/views/signups/new.html.erb under line 37, 
# create a form to gather email signups. 
# Use form_for to create a form with the fields of the @signup object
        
  <%= form_for(@signup) do |f| %>  
  <div class="field"> 
    <%= f.label :signup %><br> 
    <%= f.text_area :email %> 
  </div> 
  <div class="actions"> 
    <%= f.submit "Create" %> 
  </div> 
# <% end %> 

# confirm database entry
cd innovation-cloud
# Start the Rails console by running
$ rails console

> Signup.all