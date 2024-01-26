# frozen_string_literal: true

namespace(:update) do
  desc 'CommunityServer API BACKEND'
  task :community_server_api_backend do
    all_missing_info = []
    TestingApiOnlyOfficeCom::TestData.community_server_api_backend.each_pair do |module_name, class_hash|
      class_hash.each_pair do |_current_class, method_array|
        method_array.each do |method|
          page = TestingApiOnlyOfficeCom::CommunityServerMethodPage.new(module_name, method)
          all_missing_info << page.missing_info unless page.fully_documented?
        end
      end
    end
    File.write("#{Dir.pwd}/spec/data/failed_community_server_tests.list", all_missing_info.sort.join)
  end

  desc 'DocumentBuilder BUILDER.API'
  task :documentbuilder_builder_api do
    all_missing_info = []
    TestingApiOnlyOfficeCom::TestData.document_builder_usage_api.each_pair do |editor, class_hash|
      class_hash.each_pair do |current_class, method_array|
        method_array.each do |method|
          page = TestingApiOnlyOfficeCom::DocBuilderMethodPage.new(editor, current_class, method)
          all_missing_info << page.missing_info unless page.fully_documented?
        end
      end
    end
    File.write("#{Dir.pwd}/spec/data/failed_docbuilder_tests.list", all_missing_info.sort.join)
  end

  desc 'DocSpace API BACKEND'
  task :docspace_api_backend do
    all_missing_info = []
    TestingApiOnlyOfficeCom::TestData.docspace_api_backend.each_pair do |module_name, class_hash|
      class_hash.each_pair do |_current_class, method_array|
        method_array.each do |method|
          page = TestingApiOnlyOfficeCom::DocSpaceMethodPage.new(module_name, method)
          all_missing_info << page.missing_info unless page.fully_documented?
        end
      end
    end
    File.write("#{Dir.pwd}/spec/data/failed_docspace_tests.list", all_missing_info.sort.join)
  end
end
