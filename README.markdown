== pal.atab.le

pal.atab.le is a multi-user bookmark storing and sharing web site developed
by Nicole LaBonte.  


== Overview

pal.atab.le has the following items...

       1. controller for the bookmarks section of the site
       2. model for the bookmarks with the properties of URL, Name, Date Saved
       3. validations for the URL and name fields
       4. application layout based on an OSS design
       5. view that allows users to enter a bookmark
       6. view and partials that show a list of all bookmarks
       7. menu items to navigation menu for both of the bookmark views
       8. Actions in the controller to set up and prcoess views
       9. Tests for pages and validations
       

== Description of Contents

The default directory structure of the application:

  |-- app
  |   |-- controllers
  |   |-- helpers
  |   |-- mailers
  |   |-- models
  |   `-- views
  |       `-- layouts
  |-- config
  |   |-- environments
  |   |-- initializers
  |   `-- locales
  |-- db
  |-- doc
  |-- lib
  |   `-- tasks
  |-- log
  |-- public
  |   |-- images
  |   |-- javascripts
  |   `-- stylesheets
  |-- script
  |-- test
  |   |-- fixtures
  |   |-- functional
  |   |-- integration
  |   |-- performance
  |   `-- unit
  |-- tmp
  |   |-- cache
  |   |-- pids
  |   |-- sessions
  |   `-- sockets
  `-- vendor
      `-- plugins

app
  Holds all the code that's specific to this particular application.

app/controllers
  Holds controllers that should be named like weblogs_controller.rb for
  automated URL mapping. All controllers should descend from
  ApplicationController which itself descends from ActionController::Base.

app/models
  Holds models that should be named like post.rb. Models descend from
  ActiveRecord::Base by default.

app/views
  Holds the template files for the view that should be named like
  weblogs/index.html.erb for the WeblogsController#index action. All views use
  eRuby syntax by default.

app/views/layouts
  Holds the template files for layouts to be used with views. This models the
  common header/footer method of wrapping views. In your views, define a layout
  using the <tt>layout :default</tt> and create a file named default.html.erb.
  Inside default.html.erb, call <% yield %> to render the view using this
  layout.

app/helpers
  Holds view helpers that should be named like weblogs_helper.rb. These are
  generated for you automatically when using generators for controllers.
  Helpers can be used to wrap functionality for your views into methods.

config
  Configuration files for the Rails environment, the routing map, the database,
  and other dependencies.

db
  Contains the database schema in schema.rb. db/migrate contains all the
  sequence of Migrations for your schema.

doc
  This directory is where your application documentation will be stored when
  generated using <tt>rake doc:app</tt>

lib
  Application specific libraries. Basically, any kind of custom code that
  doesn't belong under controllers, models, or helpers. This directory is in
  the load path.

public
  The directory available for the web server. Contains subdirectories for
  images, stylesheets, and javascripts. Also contains the dispatchers and the
  default HTML files. This should be set as the DOCUMENT_ROOT of your web
  server.

script
  Helper scripts for automation and generation.

test
  Unit and functional tests along with fixtures. When using the rails generate
  command, template test files will be generated for you and placed in this
  directory.

vendor
  External libraries that the application depends on. Also includes the plugins
  subdirectory. If the app has frozen rails, those gems also go here, under
  vendor/rails/. This directory is in the load path.
