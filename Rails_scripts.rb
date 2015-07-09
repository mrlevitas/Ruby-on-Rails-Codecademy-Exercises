#!/bin/bash


$ rails new MySite

$ bundle install
	# Installs all the software packages needed by the new Rails app. 
	# These software packages are called gems and they are listed in the file Gemfile.

$ rails server
	# started the Rails development server at http://localhost:8000
	# This development server is called WEBrick

	# Set up a root route to replace this page in config/routes.rb

################################################################################
# Visit http://localhost:8000 in the browser.

# The browser makes a request for the URL http://localhost:8000.
# The request hits the Rails router in config/routes.rb. The router recognizes the URL and sends the request to the controller.
# The controller receives the request and processes it.
# The controller passes the request to the view.
# The view renders the page as HTML.
# The controller sends the HTML back to the browser for you to see.

# This is called the request/response cycle. It's a useful way to see how a Rails app's files and folders fit together.

################################################################################
# We need three parts to build a Rails app: 
# 1) a controller 
# 2) a route, 
# 3) a view.

#-------------------------------------------------------------------------------
# 1) create a CONTROLLER
$ rails generate controller Pages
	# creates file in app/controllers/pages_controller.rb

# open pages_controller.rb & modify it to:
class PagesController < ApplicationController
  def home
  end
  
end

#-------------------------------------------------------------------------------
# 2) create a ROUTE to above controller

# Open config/routes.rb & add:
get 'welcome' => 'pages#home
	# will tell Rails to send this request to the Pages controller's home action

#-------------------------------------------------------------------------------
# 3) create a View 
# open app/views/pages/home.html.erb and add:

<div class="main">
  <div class="container">
    <h1>Hello my name is __</h1>
    <p>I make Rails apps.</p>
  </div>
</div>

# CSS provided in the file app/assets/stylesheets/pages.css.scss
