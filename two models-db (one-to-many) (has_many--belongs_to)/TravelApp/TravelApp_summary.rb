$ rails new TravelApp
$ bundle install

$ rails generate model Tag
$ rails generate model Destination


# In the model files, we used the methods has_many and belongs_to 
# define an association between Tag and Destination:

# In app/models/tag.rb add
class Tag < ActiveRecord::Base
  has_many :destinations
  # denotes that a single Tag can have multiple Destinations
end

# In app/models/destination.rb, add
class Destination < ActiveRecord::Base
	belongs_to :tag
	# denotes that each Destination belongs to a single Tag
end 

# analogy
# Library has many Books; a Book belongs to a Library



# db/migrate/
class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :title
      t.string :image
      t.timestamps
    end
  end
end


class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.string :name
      t.string :image
      t.string :description
      t.references :tag
      # adds a foreign key pointing to the tags table
      t.timestamps
    end
  end
end


$ rake db:migrate
$ rake db:seed

$ rails generate controller Tags

# config/routes.rb
get '/tags' => 'tags#index'
get '/tags/:id' => 'tags#show', as: :tag
 # sends this request to the Tags controller's show action with {id: 1} in params.
get '/destinations/:id' => 'destinations#show', as: :destination
get '/destinations/:id/edit' => 'destinations#edit', as: :edit_destination 
patch '/destinations/:id' => 'destinations#update'


# app/controllers/tags_controller.rb
class TagsController < ApplicationController
	def index 
	  @tags = Tag.all 
	end

  def show 
	@tag = Tag.find(params[:id]) 
	@destinations = @tag.destinations 
  # retrieves all the destinations that belong to the tag, and stores them in @destinations. 
  # The has_many / belongs_to association lets us query for destinations like this
  end
end



$ rails generate controller Destinations

class DestinationsController < ApplicationController
  def show
    @destination = Destination.find(params[:id])
  end

  def edit 
    @destination = Destination.find(params[:id]) 
  end

  def update 
    @destination = Destination.find(params[:id]) 
    if @destination.update_attributes(destination_params) 
      redirect_to(:action => 'show', :id => @destination.id) 
    else 
      render 'edit' 
    end 
  end

private 
  def destination_params 
    params.require(:destination).permit(:name, :description) 
  end

end



# app/views/tags/index.html.erb
# <%= %>
# "If the Ruby code is preceded by just <%, then the code is executed, but its output is not inserted into the HTML stream."
# "The equal sign indicates that the output of this Ruby code is to be used as HTML."

<div class="header">
  <div class="container">
    <img src="http://s3.amazonaws.com/codecademy-content/courses/learn-rails/img/logo-1tm.svg" width="80">
    <h1>BokenjiKan</h1>
  </div>
</div>

<div class="tags">
  <div class="container">
    <div class="cards row">
    	<% @tags.each do |t| %>
      <div class="card col-xs-4">
        <%= image_tag t.image %>
        <h2><%= t.title %></h2>
        <%= link_to "Learn more", tag_path(t) %>
      </div>
      <% end %>
    </div>
  </div>
</div>




# app/views/tags/show.html.erb

<div class="header">
  <div class="container">
    <img src="http://s3.amazonaws.com/codecademy-content/courses/learn-rails/img/logo-1tm.svg" width="80">
    <h1>BokenjiKan</h1>
  </div>
</div>

<div class="tag">
  <div class="container">
    <h2><%= @tag.title %></h2>

    <div class="cards row">
      <% @destinations.each do |d| %>
      <div class="card col-xs-4">
        <%= image_tag d.image %>
        <h2><%= d.name %></h2>
        <p><%= d.description %></p>
        <%= link_to "See more", destination_path(d) %>
      </div>
      <% end %>
    </div>

  </div>
</div>


# app/views/destinations/show.html.erb

<div class="header">
  <div class="container">
    <img src="http://s3.amazonaws.com/codecademy-content/courses/learn-rails/img/logo-1tm.svg" width="80">
    <h1>BokenjiKan</h1>
  </div>
</div>

<div class="destination">
  <div class="container">
    <div class="row">
      <div class="col-xs-12">

        <!-- Your code here -->
        <%= image_tag @destination.image %>
        <h2><%= @destination.name %></h2>
        <p><%= @destination.description %></p>
      
      </div>
    </div>
  </div>
</div> 

# app/views/destinations/edit.html.erb
<div class="header">
  <div class="container">
    <img src="http://s3.amazonaws.com/codecademy-content/courses/learn-rails/img/logo-1tm.svg" width="80">
    <h1>BokenjiKan</h1>
  </div>
</div>

<div class="destination">
  <div class="container">
    <%= image_tag @destination.image %>

    <%= form_for(@destination) do |f| %>
      <%= f.text_field :name %>
      <%= f.text_field :description %>
      <%= f.submit "Update", :class => "btn" %>
    <% end %> 
    
  </div>
</div> 




 # app/views/destinations/show.html.erb
<div class="header">
  <div class="container">
    <img src="http://s3.amazonaws.com/codecademy-content/courses/learn-rails/img/logo-1tm.svg" width="80">
    <h1>BokenjiKan</h1>
  </div>
</div>

<div class="destination">
  <div class="container">
    <div class="row">
      <div class="col-xs-12">
        <%= image_tag @destination.image %>
        <h2><%= @destination.name %></h2>
        <p><%= @destination.description %></p>
        <%= link_to "Edit", edit_destination_path(@destination) %>
      </div>
    </div>
  </div>
</div>

