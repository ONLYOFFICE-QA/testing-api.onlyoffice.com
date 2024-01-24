# frozen_string_literal: true

require 'rspec/core/rake_task'
require_relative 'lib/testing_api_onlyoffice_com'

desc 'CommunityServer'
task :actualize_communityserver do
  RSpec::Core::RakeTask.new(:spec) do |task|
    task.pattern = 'spec/*/community_server/documentation_links_spec.rb'
  end
  Rake::Task['spec'].execute
end

desc 'DocumentBuilder'
task :actualize_documentbuilder do
  RSpec::Core::RakeTask.new(:spec) do |task|
    task.pattern = 'spec/*/document_builder/documentation_links_spec.rb'
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
