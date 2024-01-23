# frozen_string_literal: true

require 'rspec/core/rake_task'
require_relative 'lib/testing_api_onlyoffice_com'

desc 'Task for actualizing list of missing API info for CommunityServer'
task :update_community_server_missing_docs do
  all_missing_info = []
  TestingApiOnlyOfficeCom::CommunityServerAPI.parsed_document_entries.each_pair do |module_name, class_hash|
    class_hash.each_pair do |_current_class, method_array|
      method_array.each do |method|
        page = TestingApiOnlyOfficeCom::CommunityServerMethodPage.new(module_name, method)
        all_missing_info << page.missing_info unless page.fully_documented?
      end
    end
  end
  File.write("#{__dir__}/spec/data/failed_community_server_tests.list", all_missing_info.sort.join)
end

desc 'Task for actualizing list of missing API info for DocumentBuilder'
task :update_documentbuilder_missing_docs do
  all_missing_info = []
  TestingApiOnlyOfficeCom::BuilderPage.parsed_document_entries.each_pair do |editor, class_hash|
    class_hash.each_pair do |current_class, method_array|
      method_array.each do |method|
        page = TestingApiOnlyOfficeCom::DocBuilderMethodPage.new(editor, current_class, method)
        all_missing_info << page.missing_info unless page.fully_documented?
      end
    end
  end
  File.write("#{__dir__}/spec/data/failed_docbuilder_tests.list", all_missing_info.sort.join)
end

desc 'Task for actualizing list of missing API BACKEND for docspace'
task :update_docspace_missing_docs do
  all_missing_info = []
  TestingApiOnlyOfficeCom::TestData.docspace_api_backend.each_pair do |module_name, class_hash|
    class_hash.each_pair do |_current_class, method_array|
      method_array.each do |method|
        page = TestingApiOnlyOfficeCom::DocSpaceMethodPage.new(module_name, method)
        all_missing_info << page.missing_info unless page.fully_documented?
      end
    end
  end
  File.write("#{__dir__}/spec/data/failed_docspace_tests.list", all_missing_info.sort.join)
end

desc 'Task actualize all methods CommunityServer'
task :run_communityserver_actualizer do
  RSpec::Core::RakeTask.new(:spec) do |task|
    task.pattern = 'spec/*/community_server/documentation_links_spec.rb'
  end
  Rake::Task['spec'].execute
end

desc 'Task actualize all methods DocumentBuilder'
task :run_documentserver_actualizer do
  RSpec::Core::RakeTask.new(:spec) do |task|
    task.pattern = 'spec/*/document_builder/documentation_links_spec.rb'
  end
  Rake::Task['spec'].execute
end

desc 'Task actualize all methods DocSpace'
task :run_docspace_actualizer do
  RSpec::Core::RakeTask.new(:spec) do |task|
    task.pattern = 'spec/*/docspace/docspace_links_spec.rb'
  end
  Rake::Task['spec'].execute
end
