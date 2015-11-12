[![Code Climate](https://codeclimate.com/github/andela-ooranagwa/minly/badges/gpa.svg)](https://codeclimate.com/github/andela-ooranagwa/minly)
[![Test Coverage](https://codeclimate.com/github/andela-ooranagwa/minly/badges/coverage.svg)](https://codeclimate.com/github/andela-ooranagwa/minly/coverage)

# README
## Overview

The need to have short, easy-to-remember urls is the main major motivation behind Minly. The app enable users create short, simple memorable urls, _minlys_, for various engagements on the internet. It provides a free, flexible customization options such that users get to decide what they want their _minly_ to be. Long, complex urls can be shortened to just a single digit or letter using Minly.

Behind the scene, Minly elegantly and seamlessly redirects request to any _minly_ to their original target url; while also keep tabs of the visitors statistics. The statistics gathered are readily available for users to use in keeping track of and analyzing usage of their _minly(s)_. With this information, users get see which of their _minly_ gets more visits and manage them as they desire.

Minly allows users to manage their url. Users can redirect the target of their _minly_ , deactivate and/or delete their _minly_ . Requests to deactivated and/or deleted _minly_ will redirected with the appropriate error message.

## Using the Application

### Dependencies

Minly is built with version 4.2.4 the popular Rails framework using the Ruby programming language (version 2.1.7). Chances are you already have Ruby and Rails installed. You can run __which ruby__ and __which rails__ to check for their installation.

*   if Ruby is not installed checkout the [ruby installation guide](https://www.ruby-lang.org/en/downloads/) for guidelines to setup Ruby on your machine
*   if Rails is not installed checkout the [Rails installation guide](http://rubyonrails.org/download/) for guidelines to setup rails on you machine.

Also check for and confirm the [installation of gem](http://guides.rubygems.org/rubygems-basics/) and [bundler](http://rubygems.org) on your machine. These will allow you install other libraries ( _gems_ ) required by Minly.

### Running the application

First [clone this repo](clone). Then from your terminal (or command prompt) navigate to the folder where you have cloned Minly( __cd path/to/minly/__ ).

*   Run __bundle install__ to install all Minly dependencies.
*   Run __rake db:migrate__ to setup the app database
*   Run __rails server__ to start the rails server

You now good to go. Visit the app on your browser to use Minly (localhost:3000)

### Running the tests

Minly prides it's self in being fully tested. Minly is tested using [rspec](http://rspec.info/), [capybara](http://jnicklas.github.io/capybara/), [faker](https://github.com/stympy/faker) and [factory_girl](http://www.rubydoc.info/gems/factory_girl/file/GETTING_STARTED.md) gems. To start the test, first migrate the test database by running __rake db:migrate__. Next run __bin/rspec spec__ to run all tests. You can also specify a particular test from the spec folder to run. Run tests with the _-fd_ flag to view the tests documentation.

## App features

*   Creates _minly's_ for users if not custom string is provided
*   Creates customized _minly's_ for users if given a custom string
*   Keeps tabs of most recent _minlys_
*   Keeps tabs of popular _minlys_
*   Provides visit statistics for registered users
*   Allows users to change the target of their _minly_
*   Allows users to deactivate their _minly_
*   Allows users to delete their _minly_

## Minly API

Minly's api allows users access any of Minly's many features for supporting devices. Users will require their user token to access some user specific features using api calls. View the [Minly-gem github page](https://github.com/andela-ooranagwa/minly-gem) for more information.

To install the Minly api run __gem install "minly"__ from your terminal. You can also include it in your project by adding it (__gem "minly"__) to your gem file.

## Contributing
1. Fork the repo.
2. Run the tests. We only take pull requests with passing tests, and it's great
to know that you have a clean slate: `bundle && bundle exec rake`
3. Add a test for your change. Only refactoring and documentation changes
require no new tests. If you are adding functionality or fixing a bug, we need
a test!
4. Make the test pass.
5. Push to your fork and submit a pull request.

#####Syntax:

* Two spaces, no tabs.
* No trailing whitespace. Blank lines should not have any space.
* Prefer `&&`, `||` over `and`, `or`.
* `MyClass.my_method(my_arg)` not `my_method( my_arg )` or `my_method my_arg`.
* `a = b` and not `a=b`.
* Follow the conventions you see used in the source already.
