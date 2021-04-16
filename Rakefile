# frozen_string_literal: true

require_relative 'lib/testing_api_onlyoffice_com'

desc 'Task for actualizing list of missing API info for CommunityServer'
task :update_community_server_missing_docs do
  all_missing_info = []
  TestingApiOnlyfficeCom::CommunityServerAPI.parsed_document_entries.each_pair do |module_name, class_hash|
    class_hash.each_pair do |_current_class, method_array|
      method_array.each do |method|
        page = TestingApiOnlyfficeCom::CommunityServerMethodPage.new(module_name, method)
        all_missing_info << page.missing_info unless page.fully_documented?
      end
    end
  end
  IO.write("#{__dir__}/spec/data/failed_community_server_tests.list", all_missing_info.sort.join)
end
