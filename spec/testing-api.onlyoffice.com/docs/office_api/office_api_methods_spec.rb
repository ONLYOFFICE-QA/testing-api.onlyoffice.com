# frozen_string_literal: true

require 'spec_helper'

describe 'document_builder_documentation_content' do
  test_manager = TestingApiOnlyOfficeCom::TestManager.new(suite_name: 'Document Builder Documentation Links Content', plan_name: config.to_s)

  TestingApiOnlyOfficeCom::TestData.document_builder_usage_api.each_pair do |editor, class_hash|
    class_hash.each_pair do |current_class, method_array|
      method_array.each do |method|
        path = "#{editor}/#{current_class}/#{method}"
        context path do
          it_behaves_like 'page_docbuilder_content_exist',
                          path,
                          -> { TestingApiOnlyOfficeCom::DocBuilderMethodPage.new(editor, current_class, method) }
        end
      end
    end
  end

  after do |example|
    test_manager.add_result(example)
  end
end
