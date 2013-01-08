# SD Ruby

This app is the website of [SD Ruby](http://sdruby.org), a local Ruby user group based in San Diego, CA.

Currently, this application includes support for our video podcast, member signup and registration, member profiles, and a Github project list. We're also working on adding other features.


## System Dependencies ##

### ImageMagick ###

To work best, you must have ImageMagick installed on your local machine:

* For Linux, install using a package manager such as aptitude: `aptitude install imagemagick`
* For Mac OS X, install this via homebrew: `brew install imagemagick`

## Installation ##

``` shell
bundle install                                          # Install project dependencies
cp config/database.example.yml config/database.yml      # Configure your database(s)
cp config/app_config.example.yml config/app_config.yml  # Configure your application settings
rake sunspot:solr:start                                 # Start Solr search engine
rake db:migrate db:seed                                 # Setup database and load sample data
rake sunspot:solr:reindex                               # Index the database
rails s                                                 # Start Rails server
```

Note: You will need to add your AWS credentials and Meetup API key to `config/app_config.yml`.

## Running Tests ##

``` shell
rake db:test:prepare # if this is your first time running the tests
rspec spec
```

Tests can also be run automatically using [Guard](https://github.com/guard/guard) watchers. In order to begin watching files, simple start Guard using the `guard` command.

Please be sure to run the tests and ensure all are passing before issuing a pull request!

## Deployment ##

You can deploy to the staging or production Heroku apps, if you have the appropriate permissions, using one of the the following commands:
``` shell
rake staging deploy commit=BRANCH
rake production deploy
```

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
* [Etienne de Bruin](https://github.com/etdebruin)
* [Jordan Fowler](https://github.com/thebreeze/)
* [Istvan Hoka](https://github.com/ihoka)
* [Ben Hughes](https://github.com/rubiety/)
* [Marvin Humphrey](http://rectangular.com)
* [Sayem Islam](https://github.com/sayem/)
* [Rob Kaufman](https://github.com/notch8/)
* [Chris Kelly](https://github.com/chriskelly/)
* [Jenner LaFave](https://github.com/jenrzzz)
* [Chris McCann](https://github.com/testflyjets/)
* [James Miller](https://github.com/bensie/)
* [Ylan Segal](https://github.com/ylansegal)
* [Dan Simpson](https://github.com/dansimpson/)
* [Ethan Soutar-Rau](https://github.com/ethansr)
* [Kevin Thompson](https://github.com/kevinthompson)
* [Enrique Vidal](https://github.com/EnriqueVidal)
* [Nick Zadrozny](https://github.com/nz/)

Special thanks to the folks at [Websolr](http://websolr.com/) for providing us with a free hosted search account.
