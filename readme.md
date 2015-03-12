# Sinatra Skeleton #

This is a skeleton app for developing [Heroku](https://www.heroku.com)-deployable modular [Sinatra](http://www.sinatrarb.com) apps with [DataMapper](http://datamapper.org), [Slim](http://slim-lang.com), [RSpec](http://rspec.info) & [Capybara](https://github.com/jnicklas/capybara).

[Download the zip](https://github.com/itgsoddabe/sinatra-skeleton/archive/master.zip).

## 1 Prerequisites ###

### 1.1 Homebrew ###

Skip this step if [Homebrew](http://brew.sh) is already installed. Not sure? Try `brew -v`

1. Install Homebrew: `ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

### 1.2 Git ###

Skip this step if [git](http://git-scm.com) is already installed. Not sure? Try `git --version`

1. Install git: `brew install git`

### 1.3 Postgresql ###

Skip this step if [PostgreSQL](http://www.postgresql.org) is already installed. Not sure? Try `postgres --version`

1. Install postgresql: `brew install postgresql`

### 1.4 Rbenv & Ruby-build ###

Skip this step if [rbenv](https://github.com/sstephenson/rbenv) and [ruby-build](https://github.com/sstephenson/ruby-build) are already installed. Not sure? Try `rbenv -v` & `ruby-build --version`

1. Install rbenv: `brew install rbenv`
2. Install ruby-build: `brew install ruby-build`

### 1.5 Ruby 2.1.4 ###

Skip this step if Ruby 2.1.4 is already installed. Not sure? Try `rbenv versions`

1. Update Homebrew to get access to the latest versions of the packages: `brew update`
2. Upgrade rbenv & ruby-build: `brew upgrade rbenv ruby-build`
3. Install Ruby 2.1.4: `rbenv install 2.1.4`

### 1.6 Bundler ###

Skip this step if [Bundler](http://bundler.io) is already installed. Not sure? Try (in the app's root folder) `gem list`

1. Install bundler: `gem install bundler`
2. Give the shell access to the `bundle` executable: `rbenv rehash`

### 1.7 Heroku Toolbelt ###

Skip this step if [Heroku toolbelt](https://toolbelt.heroku.com) is already installed. Not sure? Try `heroku --version`

1. Download and install Heroku toolbelt from [toolbelt.heroku.com](https://toolbelt.heroku.com).

## 2 How the pieces fit together ##

### 2.1 Creating a git repository ###

In order to sync your repository with GitHub & deploy your app to Heroku, you will need a git repository.
This can be done from the terminal, but is probably easier done in the [GitHub client](https://mac.github.com).

1. Start the GitHub client
2. In the `File` menu, select `Add Local Repository`
3. Select app's root folder and click `add`
4. When asked if you want to "create a new git repository here?", click `Create and Add`

### 2.2 Installing required gems ###

[Gemfile](./Gemfile) contains a listing of all required gems.

1. Go to the app's root folder
2. run `bundle install`

    This will

    1. Download and install all gems listed in [Gemfile](./Gemfile)
    2. Create (or update) `Gemfile.lock`, which contains a listing of which *versions* of the gems specified in [Gemfile](./Gemfile) that have been installed.

    Heroku uses `Gemfile.lock` to install the same versions of the gems, making sure that the app will work the same way on Heroku as it does on your own machine.

3. `rbenv rehash` to give the shell access to the [rerun](https://github.com/alexch/rerun) and [racksh](https://github.com/sickill/racksh) executables.
4. Add `Gemfile.lock` to the repository, write a nice commit message, and commit the changes.

If you add a gem to [Gemfile](./Gemfile) you must rerun `bundle install` to generate a new `Gemfile.lock`.

### 2.3 Launching the app for development ###

In order to not have to manually restart the server when we are developing, we use [rerun](https://github.com/alexch/rerun). Rerun will watch the app's folder,
and automatically restart the server when it detects a change in a file.

1. `rerun rackup --ignore "*.{slim,js,css,coffee}"`

    This will launch rerun, which will, in turn, start the server using `rackup`. The `--ignore` argument tells rerun *not* to restart the app if it detects changes in .slim, .js, .css or .coffee files (changes in these
    types of files do not require a relaunch of the server)

    `rackup` will look in [config.ru](./config.ru) for instructions on how to start the server.

2. Look for the line telling which port the server is running on (normally 9292)

        [2015-02-04 23:50:03] INFO  WEBrick::HTTPServer#start: pid=27424 port=9292

3. Launch your browser and point it to `localhost:9292`

### 2.4 Running the tests ###

There are three different types of tests, testing different aspects of the application.

The tests are run using rake tasks, specified in [rakefile](./rakefile).

#### 2.4.1 Route tests ####

Route tests test the routes (get and/or post) specified in [app.rb](./app.rb).

Route tests are located in `test/routes/`

Look in [test/routes/base_test.rb](./test/routes/sample_test.rb) for examples of what you can test using route tests.

1. To run route tests: `rake test:routes`
2. To create new route tests: create files named `*_test.rb` in `test/routes/`

#### 2.4.2 Model tests ####

Model tests test the models specified in `models/`

Model tests are located in `test/models`

Look in [test/models/sample_test.rb](./test/models/sample_test.rb) for examples of what you can test using model tests

1. To run model tests: `rake test:models`
2. To create new model tests: create files named `name_of_model_test.rb` in `test/models`

#### 2.4.3 Acceptance tests ####

Acceptance tests test the *entire* application; routes, models, database, and frontend.

If the tests do not rely upon javascript, the tests are in a headless browser using [Capybara](https://github.com/jnicklas/capybara).

If the tests require javascript, the tests must be run in a programatically controlled browser using [Selenium](http://www.seleniumhq.org).

Look in [test/acceptance/sample_spec.rb](./test/acceptance/sample_spec.rb) for examples of what you can test using acceptance tests.

1. To run acceptance tests: `rake test:acceptance`
2. To create new acceptance tests: create files named `name_of_feature_spec.rb` in `test/acceptance`

### 2.5 Deploying the app to Heroku ###

**Since Heroku uses the git repository for deployment, you must *always* commit the latest changes to the repository before
deploying the app.**

1. In the apps root folder, run `heroku create`

    This creates an empty app on Heroku, ready to accept your application, and tells git how to push the application to Heroku.

2. Install the Heroku Postgresql addon: `heroku addons:add heroku-postgresql:dev`

3. In the apps root folder, run `git push heroku master`

    This pushes the application to Github. Gitub then:

    1. Determines what kind of app it is (in our case Ruby).
    2. Downloads and installs the gems specified in `Gemfile.lock` (but only the ones specified in the `production` group).

    Heroku caches the gems so it does not have to install them every time you push changes to the app.

    3. Starts the applications server running the command specified in [Procfile](./Procfile)

    To view the application, either run `heroku open`, which points your web browser to the app's url, or tell the browser to go there manually.

### 2.5.1 Seeding the database ####

Since we have a new database, none of the data has been transferred.

1. Run `heroku run rake db:seed` to seed the database from [db/seed.rb](./db/seed.rb)

### 2.5.2 Troubleshooting ###

Sometimes the app won't start, or maybe it will crash. To view the logs, run

1. `heroku logs` in the apps root folder.

Sometimes you might feel the need to do some "[cowboy coding](http://en.wikipedia.org/wiki/Cowboy_coding)".

1. To access the app's console: `heroku run racksh`