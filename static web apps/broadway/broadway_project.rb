
# http://guides.rubyonrails.org/command_line.html
$ rails s -p 8080 # start server on port 8080

$ rails new broadway
$ cd broadway
$ bundle install

$ rails generate controller Pages

# open pages_controller.rb & modify it to:
class PagesController < ApplicationController
  def home
  end
  
end

# Open config/routes.rb & add:
get 'pages/home' => 'pages#home'


# naah, actually do this:
# set the home action as the app's home page.
root 'pages#home'

# (re)start server as necessary
$ rails s -p 8080

# port issue with vagrant
# http://stackoverflow.com/questions/27799260/rails-4-2-server-port-forwarding-on-vagrant-does-not-work

# navigate to root
http://localhost:8080/

# app/views/pages/home.html.erb 
# in the header, add four list items for About, Work, Team and Contact.
<div class="header">
      <div class="container">
        
        <div id="HorizontalList">
        <ul>
          <li>About</li>
          <li>Work</li>
          <li>Team</li>
          <li>Contact</li>
        </ul>
        </div>
      
      </div>
    </div>





    <div class="jumbotron">
      <div class="container">  
        <div class="main">
          <h1>We are Broadway</h1>
          
          <a href="#" class="myButton">Get Started</a>

        </div>
      </div>
    </div>

# CSS in 
# app/assets/stylesheets/pages.css.scss 
# display list on the same line.
# http://css.maxdesign.com.au/listutorial/horizontal_master.htm

#HorizontalList ul
{
margin: 0;
padding: 15px;
list-style-type: none;
text-align: center;
}

#HorizontalList ul li { display: inline; }

#HorizontalList ul li a
{
text-decoration: none;
padding: .2em 1em;
color: #FFFFFF;
background-color: #036;
}

# add background image

html { 
  background: url(https://s3.amazonaws.com/codecademy-content/projects/broadway/bg.jpg) no-repeat center center fixed; 
  -webkit-background-size: cover;
  -moz-background-size: cover;
  -o-background-size: cover;
  background-size: cover;
}


# add button
.myButton {
	-moz-box-shadow:inset 0px 1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px 1px 3px 0px #91b8b3;
	box-shadow:inset 0px 1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	-moz-border-radius:5px;
	-webkit-border-radius:5px;
	border-radius:5px;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:15px;
	font-weight:bold;
	padding:11px 23px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}



