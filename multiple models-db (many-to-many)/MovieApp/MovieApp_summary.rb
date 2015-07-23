# 1)
$ rails new MovieApp
$ cd MovieApp
$ bundle install

# 2)
$ rails generate model Movie
$ rails generate model Actor
$ rails generate model Part

# 3)
# create many-to-many relationship in models
# see many-to-many.png in folder
# app/models/movie.rb
class Movie < ActiveRecord::Base
	has_many :parts 
	has_many :actors, through: :parts
end

# app/models/actor.rb
class Actor < ActiveRecord::Base
	has_many :parts 
	has_many :movies, through: :parts
end

# app/models/part.rb
class Part < ActiveRecord::Base
	belongs_to :movie 
	belongs_to :actor
end

# 4)
# db/migrate/
class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
		 t.string :title
		 t.string :image
		 t.string :release_year
		 t.string :plot
      t.timestamps
    end
  end
end

class CreateActors < ActiveRecord::Migration
  def change
    create_table :actors do |t|
      t.string :first_name
      t.string :last_name
      t.string :image
      t.string :bio
      t.timestamps
    end
  end
end


class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
		 t.belongs_to :movie, index: true 
		 t.belongs_to :actor, index: true
      t.timestamps
    end
  end
end


# 5)
$ rake db:migrate
$ rake db:seed

# 6)
$ rails generate controller Movies

# 7)
# add route
# config/routes.rb
get '/movies' => 'movies#index'
get '/movies/:id' => 'movies#show', as: :movie
# By giving the show route a name of "movie", Rails automatically creates a helper method named movie_path, 
# so use it to generate a URL to a specific movie's path
get '/actors' => 'actors#index'
get '/actors/:id' => 'actors#show' , as: :actor

# 8)
# add index & show action to Movies controller
# app/controllers/movies_controller.rb

class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id]) 
    @actors = @movie.actors
  end
end

# 9)
# app/views/movies/index.html.erb
<div class="hero">
  <div class="container">
    <h2>Interstellar</h2>
#REMOVE_ME		 <p>Former NASA pilot Cooper (Matthew McConaughey) and a team of researchers travel across the galaxy to find out which of three planets could be mankind's new home.</p>
    <a href="#">Read More</a>
  </div>
</div>

<div class="main">
  <div class="container">
  <h2>Popular Films</h2>

    <!--To do: Loop through movies and display each one with this HTML-->
    <% @movies.each do |movie| %>
    <div class="movie">
      <%= image_tag movie.image %>
      <h3><%=movie.title %></h3>
      <p> <%=movie.release_year %> </p>
      <%= link_to "Learn More", movie_path(movie) %> 
    </div>
    <% end %>

  </div>
</div>

# 10)
# app/views/movies/show.html.erb
<div class="main movie-show">
  <div class="container">
    <div class="movie">
      
      <!-- Display the movie's info here -->
      <div class="info">
        <!-- movie image -->
        <%= image_tag @movie.image %>
        <h3 class="movie-title"><%=@movie.title %></h3>
        <p class="movie-release-year"><%=@movie.release_year %></p>
        <p class="movie-plot"><%=@movie.plot%></p>
      </div>
    </div>

    <h2>Cast</h2>
    <!-- Display each actor's info here -->
     <% @actors.each do |actor| %>
    <div class="actor">
      <!-- actor image -->
      <%= image_tag actor.image %>
      <h3 class="actor-name"><%=actor.first_name%> <%=actor.last_name%> </h3>
      <p class="actor-bio"><%=actor.bio%></p>
    </div>
	<% end %>
  
  </div>
</div>


# 11)
$ rails generate controller Actors

# 12)
# app/controllers/actors_controller.rb
class ActorsController < ApplicationController
  def index
  	@actors = Actor.all
  end

  def show
    @actor = Actor.find(params[:id]) 
    @movies = @actor.movies
  end
end


# 13)
# app/views/actors/index.html.erb
<div class="main actor-index">
      <div class="container">
        <div class="row">

          <!--
          To do: Loop through movies and display each one with this HTML-->
 				<% @actors.each do |actor| %>
          <div class="actor col-xs-2">
            <%= image_tag actor.image %>
            <h3><%=actor.first_name%> <%=actor.last_name%></h3>
            <%= link_to "Learn More", actor_path(actor) %> 
            <p><%=actor.bio%></p>
          </div>
          <% end %>
          
      </div>
</div>
