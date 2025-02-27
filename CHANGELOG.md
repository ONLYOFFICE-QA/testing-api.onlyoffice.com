# Change log

## master (unreleased)

### New Features

* Refactoring `workspace`
* nokogiri parse & check docspace methods page
* Global refactoring
* Add docspace link tests
* Add `markdownlint` support in CI
* Add `yamllint` support in CI
* Add `dependabot check` for `GitHub Actions`
* Add `ruby-3.4` to CI

### Changes

* Remove 'codeclimate` config, since we don't use any more
* Check `dependabot` at 8:00 Moscow time daily
* Run browser CI check on production `https://legacy-api.onlyoffice.com`

### Fixes

* Run `rubocop` in CI through `bundle exec`
