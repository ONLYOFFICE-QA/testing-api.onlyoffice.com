# testing-api.onlyoffice.com

## Getting start

For local startup in developer mode,
recommended installing a local `bundle config` file.

   ```shell
    bundle config set --local with development
   ```

Afterwards install the dependencies with the bundle.

   ```shell
    bundle install
   ```

## How to run tests

In order to execute tests use following commands:

## Locally

1. Bundler will install all needed gems

   `bundle install`

2. Replace path to file you want to run
  
   ```shell
    rspec spec/[functional]/[specific_spec_file.rb]
   ```

## Remotely on `wrata`

1. Login to your [wrata](<https://github.com/ONLYOFFICE/testing-wrata>) instance
with user `api.onlyoffice.com` (Login info stored in secret password file)

2. Go to **wrata-url/clients/api_keys** and locally call
  command to initialize API

   ![image](https://user-images.githubusercontent.com/668524/203771978-69fcc09a-1f10-4167-99a1-3dcf7f83bfde.png)

3. run tests on **api.teamlab.info**

    `rake wrata:run_tests`

    or

   run tests on **api.onlyoffice.com**

    `rake wrata:run_tests_on_production`

## Test description

All spec files are rather fast to run, around **1 hour** all of them except two file:

   ```shell
    spec/testing-api.onlyoffice.com/community_server/documentat_links_content_spec.rb
   ```

   ```shell
    spec/testing-api.onlyoffice.com/document_builder/documentation_links_content_spec.rb
   ```

Both those file check a lot of pages for content, so they are *slow*.
It took around **several hours** to run each of them, maybe even more if
palladium slow downs a bit

## How to check new `major` version of documentation

### CommunityServer

1. Run locally. It *will fail* if some new methods was added to list of API Methods.

   ```shell
    rake actualize_communityserver
   ```

2. Manually edit to correctly add new methods to list of API Methods

   ```shell
    templates/community_server/api_backend.json
   ```

3. Run to actualize list of missing docs.  

   ```shell
    rake update:community_server_api_backend
   ```

   >It will produce new `spec/data/failed_community_server_tests.list`.  
   Check with **developers**, that it's ok to miss those links

4. Run to check that all data is the same as in `failed_community_server_tests.list`

   ```shell
    rspec spec/testing-api.onlyoffice.com/community_server/documentation_links_content_spec.rb
   ```

### Docs

1. Run locally. It *will fail* if some new methods was added to list of API Methods.

   ```shell
    rake actualize_office_api_methods
   ```

2. Manually edit to correctly add new methods to list of **API Methods**

   ```shell
    templates/document_builder/usage_api.json
   ```

3. Run to actualize **list of missing** docs.

   ```shell
    rake update:documentbuilder_office_api
   ```

   >It will produce new `spec/data/failed_docbuilder_tests.list`
    Check with *developers*, that it's ok to miss those links

4. Run to check that all data is the same as in.

   ```shell
    rspec spec/testing-api.onlyoffice.com/docs/office_api/office_api_method_links_spec.rb
   ```

### DocSpace

1. Run locally. It *will fail* if some new methods was added to list of API Methods.

   ```shell
    rake actualize_docspace
   ```

2. Manually edit to correctly add new methods to list of **API Methods**

   ```shell
    templates/docspace/api_backend.json
   ```

3. Run to actualize **list of missing** docs.

   ```shell
    rake update:docspace_api_backend
   ```

   >It will produce new `spec/data/failed_docbuilder_tests.list`
   Check with *developers*, that it's ok to miss those links

4. Run to check that all data is the same as in.

   ```shell
    rspec spec/testing-api.onlyoffice.com/docspace/docspace_links_content_spec.rb
   ```
