# 1)
$ rails new bass-music
$ cd bass-music
$ bundle install

# 2)
$ rails generate model Album
$ rails generate model Track

# 3)
# Associate the Album model with the Track model using the has_many and 
# belongs_to methods

class Album < ActiveRecord::Base
  has_many :tracks
end

class Track < ActiveRecord::Base
  belongs_to :album
end

# 4)
# db/migrate/
class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :cover
      t.string :title
      t.string :artist
      t.timestamps
    end
  end
end

class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :minutes
      t.references :album
      t.timestamps
    end
  end
end

# 5)
# run Migration
$ rake db:migrate

# 6)
# seed the db with included file
# db/seeds.rb

# 7)
$ rake db:seed

# 8) 
$ rails generate controller Albums

# bass-music/app/controllers/albums_controller.rb
class AlbumsController < ApplicationController
  def index
    @albums = Album.all
  end

  def show
    @album = Album.find(params[:id])
    @tracks = @album.tracks
  end
end


# 9)
# add resource route for Albums controller
# bass-music/config/routes.rb
resources :albums
root 'albums#index'

# 10)
$ rake routes

# 11)
# copy/paste layout file into:
# app/views/layouts/application.html.erb

# 12)
# In the view app/views/albums/index.html.erb, 
# loop through each element in @albums and display an album's details.

<div class="row">
  
  <!--
  TODO: Loop through each album and display each one with this HTML-->

<% @albums.each do |album| %>
  <div class="col-md-3">
    <%= link_to(album) do %>
      <div class="thumbnail">
        <img src="<%= album.cover %>">
        <div class="caption">
		  <h3 class="title"> <%= album.title %> </h3>
          <p class="artist"> <%= album.artist %> </p>
        </div>
      </div>
    <% end %>
  </div>
   <% end %>
  
</div>

















