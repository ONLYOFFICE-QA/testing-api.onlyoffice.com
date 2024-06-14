# frozen_string_literal: true

require 'rspec/core/rake_task'
require_relative 'lib/testing_api_onlyoffice_com'

desc 'Workspace'
task :actualize_workspace do
  RSpec::Core::RakeTask.new(:spec) do |task|
    task.pattern = 'spec/*/community_server/documentation_links_spec.rb'
  end
  Rake::Task['spec'].execute
end

desc 'OfficeApi methods'
task :actualize_office_api_methods do
  RSpec::Core::RakeTask.new(:spec) do |task|
    task.pattern = 'spec/*/docs/office_api/office_api_method_links_spec.rb'
  end
  Rake::Task['spec'].execute
end

desc 'DocSpace'
task :actualize_docspace do
  RSpec::Core::RakeTask.new(:spec) do |task|
    task.pattern = 'spec/*/docspace/docspace_links_spec.rb'
  end
  Rake::Task['spec'].execute
end
