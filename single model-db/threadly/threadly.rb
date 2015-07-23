$ rails new threadly
$ cd threadly
$ bundle install
$ rails generate model Post


 # db/migrate/
 # add a string column called comment
class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :comment
      t.timestamps
    end
  end
end

$ rake db:migrate

$ rails generate controller Posts

# In the routes file, add the resource route resources :posts.
  resources :posts
  root 'posts#index'


$ rake routes

# In the Posts controller, make an action named index and
# Set up the posts#create controller action to handle POST requests:
class PostsController < ApplicationController
  def index
    @new_post = Post.new
    @all_posts = Post.order(created_at: :desc).all
  end

  def create
      @new_post = Post.new(post_params) 
      if @new_post.save 
	    redirect_to '/' 
	  else 
	    render 'root_path' 
	  end     
  end
  
  private
  
  def post_params
    params.require(:post).permit(:comment)
  end
end




# In app/views/posts/index.html
# create a Rails form with the fields of the @new_post object to post comments
# and use @all_posts to display comments
        <!-- Form goes here -->
  <%= form_for(@new_post) do |f| %>  
  <div class="field"> 
    <%= f.label :post %><br> 
    <%= f.text_area :comment %> 
  </div> 
  <div class="actions"> 
    <%= f.submit "Create" %> 
  </div> 
 <% end %>
        
  <ul class="comments">
	  <% @all_posts.each do |p| %>
	  <li><%= p.comment %></li>
 	  <% end %>
	</ul>



# confirm database entry
$ cd threadly
# Start the Rails console by running
$ rails console

> Posts.all