# frozen_string_literal: true

require 'spec_helper'
describe 'document_builder_documentation_content' do
  test_manager = TestingApiOnlyfficeCom::TestManager.new(suite_name: 'Document Builder Documentation Links Content', plan_name: config.to_s)

  TestingApiOnlyfficeCom::BuilderPage.parsed_document_entries.each_pair do |editor, class_hash|
    class_hash.each_pair do |current_class, method_array|
      method_array.each do |method|
        path = "#{editor}/#{current_class}/#{method}"
        context path do
          it_behaves_like 'page_content_exist', path, (-> { TestingApiOnlyfficeCom::DocBuilderMethodPage.new(editor, current_class, method) })
        end
      end
    end
  end

  after :each do |example|
    test_manager.add_result(example)
  end
end
