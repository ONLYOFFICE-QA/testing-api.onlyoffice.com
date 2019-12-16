# frozen_string_literal: true

require 'spec_helper'
describe 'community_server_documentation_content' do
  test_manager = TestingApiOnlyfficeCom::TestManager.new(suite_name: 'Community Server Documentation Links Content', plan_name: config.to_s)

  TestingApiOnlyfficeCom::CommunityServerAPI.parsed_document_entries.each_pair do |module_name, class_hash|
    class_hash.each_pair do |_current_class, method_array|
      method_array.each do |method|
        path = "#{module_name}/#{method}"
        context path do
          it_behaves_like 'page_content_exist', path, (-> { TestingApiOnlyfficeCom::CommunityServerMethodPage.new(module_name, method) })
        end
      end
    end
  end

  after :each do |example|
    test_manager.add_result(example)
  end
end
