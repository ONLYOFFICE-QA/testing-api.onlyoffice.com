# testing-api.onlyoffice.com

## How to run tests

In order to execute tests use following commands:

## Locally

1. Bundler will install all needed gems

   `bundle install`

2. Replace path to file you want to run
  
    ```bash
      rspec spec/functional/specific_spec_file.rb
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

  ```bash
    spec/testing-api.onlyoffice.com/community_server/documentat_links_content_spec.rb
  ```

  ```bash
    spec/testing-api.onlyoffice.com/document_builder/documentation_links_content_spec.rb
  ```

Both those file check a lot of pages for content, so they are *slow*.
It took around **several hours** to run each of them, maybe even more if
palladium slow downs a bit

## How to check new `major` version of documentation

### CommunityServer

1. Run locally. It *will fail* if some new methods was added to list of API Methods.

    `rspec spec/testing-api.onlyoffice.com/community_server/documentation_links_spec.rb`

2. Manually edit to correctly add new methods to list of API Methods

    ```bash
      lib/testing_api_onlyoffice_com/test_instance/main_page/community_server_api/document_entries.json
    ```

3. Run to actualize list of missing docs.  

      `rake update_community_server_missing_docs`

      It will produce new `spec/data/failed_community_server_tests.list`.  
      Check with **developers**, that it's ok to miss those links

4. Run to check that all data is the same as in `failed_community_server_tests.list`

      `rspec spec/testing-api.onlyoffice.com/community_server/documentation_links_content_spec.rb`
  
### DocumentBuilder

1. Run locally. It *will fail* if some new methods was added to list of API Methods.

    `rspec spec/testing-api.onlyoffice.com/document_builder/documentation_links_spec.rb`

2. Manually edit to correctly add new methods to list of **API Methods**

    ```bash
      lib/testing_api_onlyoffice_com/test_instance/main_page/document_builder_api/document_builder_api_common/document_entries.json
    ```

3. Run to actualize **list of missing** docs.

    `rake update_documentbuilder_missing_docs`

    It will produce new

   ```bash
   spec/data/failed_docbuilder_tests.list
   ```

    Check with *developers*, that it's ok to miss those links

4. Run to check that all data is the same as in.

    `rspec spec/testing-api.onlyoffice.com/document_builder/documentation_links_content_spec.rb`
