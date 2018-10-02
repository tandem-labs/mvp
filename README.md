# Tandem Labs MVP

[![CircleCI](https://circleci.com/gh/tandem-labs/mvp.svg?style=svg&circle-token=dc52b6c195bfce39c2e2e038218bafc99ce4b694)](https://circleci.com/gh/tandem-labs/mvp) [![Coverage Status](https://coveralls.io/repos/github/tandem-labs/mvp/badge.svg?branch=master&t=xQse3d)](https://coveralls.io/github/tandem-labs/mvp?branch=master)

## Development

### Install development environment on Mac OSX

* System dependencies

  * A Postgres database server; typically installed using home brew
    * `brew install postgresql`
  * Use `rvm` for ruby version management
    * Ensure you have the right ruby version installed `rvm install ruby-2.5.1`
    * `.ruby-version` file should auto load correct ruby version when you `cd` into the folder

* Setup
  * Run `bundle` to install gem dependencies
  * Run `rails db:create db:migrate db:seed db:test:prepare` to setup your local database
  * Start the application: `rails s`

### Running Tests

* `rake` will run the default rake task which runs the specs and lint check
* Alternatively they can be run independently:
  * `rspec spec`
  * `rubocop`

NOTE: depending on your environment you may need to prefix your rails commands with `bundle exec` or use `bin/rails`. You might consider using a unix `alias` to avoid having to do this every time.

### Testing email in development

We use mailcatcher to catch outgoing email and display in the browser in development:

* Install with `gem install mailcatcher --no-ri --no-rdoc`
* Run from command line: `mailcatcher`
* View emails in your browser at: http://127.0.0.1:1080

## Deployment

We use Heroku for hosting. We have both a staging and a production account:

* Staging: `tandem-labs-mvp-staging`
* Production: `tandem-labs-mvp-production`

To deploy:

* Create a new Github PR which will create a new Heroku Pipeline app
* Get approval from QA & the product owner on the PR app URL
* Get approval from another developer on your PR code
* Merge the PR into master via Github which will trigger a build on the staging app
* Once built, sanity-check one more time on the staging app URL
* Click "Promote to Production"
* Once live, sanity-check one last time on the production app URL
