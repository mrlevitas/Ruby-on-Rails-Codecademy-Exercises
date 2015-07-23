# 1)
$ rails new bookmarks
$ cd bookmarks
$ bundle install

# 2)
$ rails generate model Book
$ rails generate model Review

# 3)
# Associate the Book model with the 
# Review model using the has_many and belongs_to methods

# app/models/book.rb
class Book < ActiveRecord::Base
  has_many :reviews
end

# app/models/review.rb
class Review < ActiveRecord::Base
  	belongs_to :book
end

# 4)
# db/migrate/ 
class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :description
      t.string :publisher
      t.integer :weeks_on_list
      t.integer :rank_this_week
      t.timestamps
    end
  end
end


class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
		 t.string :author
      t.string :comment
      t.references :book
      # foreign key relationship
      t.timestamps
    end
  end
end

# 5)
$ rake db:migrate

# 6) 
# populate db/seeds.rb file and run:
$ rake db:seed

# 7)
$ rails generate controller Books


# 8)
# bookmarks/config/routes.rb
  resources :books
  root 'books#index'

# 9)
$ rake routes

# 10)
# add to books controller
class BooksController < ApplicationController
  def index
    @books = Book.all
  end
  
  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews
  end
end


# 11)
# bookmarks/app/views/books/index.html.erb 

<% @books.each do |book| %>
  <div class="book">
    <div class="row">
      <div class="col-md-1">
        <p class="rank-this-week"> <%=book.rank_this_week%> </p>
      </div>
      <div class="col-md-9">
        <p class="title"><%=book.title%>  </p>
        <p class="author">by <%=book.author%>  </p>
        <p class="publisher">(<%=book.publisher%> )</p>
        <p class="description"> <%=book.description%> </p>
        <%= link_to 'See all Editorial Reviews', book %>
      </div>
      <div class="col-md-2">
        <p class="weeks-on-list">  <%=book.weeks_on_list%></p>
      </div>
    </div>
  </div>
# <% end %>



# 12) 
# bookmarks/app/views/books/show.html.erb
<div class="book">
  <p class="title">  <%=@book.title%> </p>
  <p class="author">by  <%=@book.author%> </p>
  <p class="publisher">(<%=@book.publisher%> )</p>
  <p class="description"> <%=@book.description%> </p>
</div>

<div class="reviews">
  <% @reviews.each do |review| %>
    <div class="review">
      <p class="author"> <%=review.author%> </p>
      <p class="comment"><%=review.comment%>  </p>
    </div>
  <% end %>
</div>
