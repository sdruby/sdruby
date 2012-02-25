# SD Ruby

This app is the website of [SD Ruby](http://sdruby.org), a local Ruby user group based in San Diego, CA.

Currently, this application includes support for our video podcast, member signup and registration, member profiles, and a Github project list. We're also working on adding other features.

## Development Setup ##

Run:

    $ bundle install
    $ sass --watch public/stylesheets:public/stylesheets/compiled
    $ rails s

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
* [Patrick Crowley](https://github.com/mokolabs/)
* [Jimmy Cuadra](https://github.com/jimmycuadra)
* [Jordan Fowler](https://github.com/thebreeze/)
* [Ben Hughes](https://github.com/rubiety/)
* [Marvin Humphrey](http://rectangular.com)
* [Rob Kaufman](https://github.com/notch8/)
* [James Miller](https://github.com/bensie/)
* [Nick Zadrozny](https://github.com/nz/)
