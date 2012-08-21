# SD Ruby

This app is the website of [SD Ruby](http://sdruby.org), a local Ruby user group based in San Diego, CA.

Currently, this application includes support for our video podcast, member signup and registration, member profiles, and a Github project list. We're also working on adding other features.


## System Dependencies ##

### ImageMagick ###

To work best, you must have ImageMagick installed on your local machine:

* For Linux: This is best installed with your package manager. For Debian-flavored distributions (Ubuntu), use: "aptitude install imagemagick".
* For Mac OS X: The best approach is to install this via homebrew: "brew install imagemagick".

## Installation ##

* bundle install
* configure config/database.yml with your preferred settings (You can use the provided database.example.yml file to use sqlite3)
* Setup database and load sample data (rake db:migrate db:data:load)
* rake sunspot:solr:start (to start the solr search engine)
* rake sunspot:solr:reindex (to index the database)
* sass --watch public/stylesheets:public/stylesheets/compiled
* rails s

## Running Tests ##

* rake db:test:prepare  (if this is your first time running the tests)
* rspec spec

We also have [Guard](https://github.com/guard/guard) set up:

* guard

Please be sure to run the tests and ensure all are passing before issuing a pull request!

## Deployment ##

There are are staging and production apps hosted on Heroku's cedar stack.

You can deploy to Heroku if you have app permissions via rake staging deploy commit=BRANCH or rake production deploy.

Deployment tasks will automatically run any pending migrations.

## Features ##

### Podcast ###

Thanks to UCSD, we're able to record SD Ruby meetings, and publish our talks as a [video podcast](http://sdruby.org/podcast).

The podcast code can generate both an Atom feed and an RSS feed (with custom iTunes RSS extensions).

### Member Guide ###

The [member guide](http://sdruby.org/users) contains a list of all SD Ruby members.

Member profiles can include:

* Full name
* Avatar image
* Github ID
* Neighborhood
* Ruby experience
* Work availability
* Contact email (if public)

### Project List ###

The [list of projects](http://sdruby.org/projects) shows all Github projects created by SD Ruby members.

## Contributors ##

Thanks to the following people for contributing to this app.

* [Neal Clark](https://github.com/nclark/)
* [Rafael Cardoso](https://github.com/rafamvc)
* [Patrick Crowley](https://github.com/mokolabs/)
* [John Cozen](https://github.com/mediamaker)
* [Jimmy Cuadra](https://github.com/jimmycuadra)
* [Jordan Fowler](https://github.com/thebreeze/)
* [Ben Hughes](https://github.com/rubiety/)
* [Marvin Humphrey](http://rectangular.com)
* [Sayem Islam](https://github.com/sayem/)
* [Rob Kaufman](https://github.com/notch8/)
* [Chris Kelly](https://github.com/chriskelly/)
* [Chris McCann](https://github.com/testflyjets/)
* [James Miller](https://github.com/bensie/)
* [Dan Simpson](https://github.com/dansimpson/)
* [Nick Zadrozny](https://github.com/nz/)

Special thanks to the folks at [Websolr](http://websolr.com/) for providing us with a free hosted search account.
