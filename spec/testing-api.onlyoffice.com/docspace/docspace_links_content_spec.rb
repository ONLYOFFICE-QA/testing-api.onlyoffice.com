# frozen_string_literal: true

require 'spec_helper'
describe 'docspace_documentation_content' do
  test_manager = TestingApiOnlyOfficeCom::TestManager.new(suite_name: 'DocSpace Documentation Links Content', plan_name: config.to_s)

  TestingApiOnlyOfficeCom::TestData.docspace_api_backend.each_pair do |module_name, class_hash|
    class_hash.each_pair do |_current_class, method_array|
      method_array.each do |method|
        path = "#{module_name}/#{method}"
        context path do
          it_behaves_like 'page_content_exist', path, -> { TestingApiOnlyOfficeCom::DocSpaceMethodPage.new(module_name, method) }
        end
      end
    end
  end

  after do |example|
    test_manager.add_result(example)
  end
end
