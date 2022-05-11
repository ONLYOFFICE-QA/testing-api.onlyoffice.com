# testing-api.onlyoffice.com

## How to check new major version of documentation

### CommunityServer

1. Run `rspec spec/testing-api.onlyoffice.com/community_server/documentation_links_spec.rb`
  locally.  
  It will fail if some new methods was added to list of API Methods
2. Manually edit `lib/testing_api_onlyoffice_com/test_instance/main_page/community_server_api/document_entries.json`
  to correctly add new methods to list of API Methods
3. Run `rake update_community_server_missing_docs` to
  actualize list of missing docs.  
  It will produce new `spec/data/failed_community_server_tests.list`.  
  Check with developers, that it's ok to miss those links
4. Run `rspec spec/testing-api.onlyoffice.com/community_server/documentat_links_content_spec.rb`
  to check that all data is the same as in `failed_community_server_tests.list`

### DocumentBuilder

1. Run `rspec spec/testing-api.onlyoffice.com/document_builder/documentation_links_spec.rb`
  locally.  
  It will fail if some new methods was added to list of API Methods
2. Manually edit `lib/testing_api_onlyoffice_com/test_instance/main_page/document_builder_api/document_builder_api_common/document_entries.json`
  to correctly add new methods to list of API Methods
3. Run `rake update_documentbuilder_missing_docs` to
  actualize list of missing docs.  
  It will produce new `spec/data/failed_docbuilder_tests.list`.  
  Check with developers, that it's ok to miss those links
4. Run `rspec spec/testing-api.onlyoffice.com/document_builder/documentation_links_content_spec.rb`
  to check that all data is the same as in `failed_community_server_tests.list`
