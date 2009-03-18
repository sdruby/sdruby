# SD Ruby 2.0 #

We're working on this app in a few phases.

In the first phase, we'll update the site design and merge the podcast site into the main website. In the second phase, we'll work towards adding support for calendaring and podcast workflows. Then, we'll work on abstracting this project into something other groups can use.

Here's a breakdown of the first phase.

### Tasks ###
- Get running length and file size (in bytes) for all episodes
- Update feedburner feed with new iTunes-compatible RSS feed

### Completed ###
- Add simple auth for editing/deleting podcast episodes [Rob]
- Move podcast files over to sdruby.com (update links accordingly) [Rob]
- Add permanent redirects for old podcast links [Rob]
- Add support for image attachments via Paperclip [Patrick]
- Update rake task to import old attachments into new setup [Patrick]
- Update podcast image on iTunes [Patrick]
- Atom feed of podcast episodes for iTunes, etc [Patrick]
- Add jQuery-based filter for showing podcast episodes by year [Patrick]
- Strip tags from episode descriptions when viewed in lists [Patrick]
- Add textile support for descriptions [Patrick]
- Create Rake task to import old podcast data [Patrick]
- Add model for Podcast [Patrick]
- Complete podcast index action [Patrick]
- Complete podcast show action [Patrick]
- Complete podcast new action [Patrick]
- Complete podcast edit action [Patrick]
- Markup and style podcast home [Patrick]
- Markup and style podcast detail [Patrick]
- Create basic podcast controller [Patrick]
- Unfreeze Rails [Rob]
- Update plugins [Rob]
- Update the app to Rails 2.2.2 [Rob]
- Switch gems to use config.gem [Rob]
- Markup and style basic layout [Patrick]
- Markup and style homepage [Patrick]
