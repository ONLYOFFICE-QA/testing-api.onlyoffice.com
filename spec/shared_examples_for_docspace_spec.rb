# frozen_string_literal: true

shared_examples_for 'page_docspace_content_exist' do |path, documentation_page|
  describe 'element_include?' do
    let!(:failed_docspace_tests) { File.read("#{__dir__}/data/failed_docspace_tests.list").split("\n") }

    before :all do
      @documentation_page = documentation_page.call
    end

    it "#{path}/Parameters" do
      pending 'https://github.com/ONLYOFFICE/api.onlyoffice.com/issues/576' if failed_docspace_tests.include?("#{path}/Parameters")
      expect(@documentation_page.params_exist).to be_truthy
    end

    it "#{path}/Returns" do
      pending 'https://github.com/ONLYOFFICE/api.onlyoffice.com/issues/576' if failed_docspace_tests.include?("#{path}/Returns")
      expect(@documentation_page.return_exist).to be_truthy
    end

    it "#{path}/Example" do
      pending 'https://github.com/ONLYOFFICE/api.onlyoffice.com/issues/576' if failed_docspace_tests.include?("#{path}/Example")
      expect(@documentation_page.example_exist).to be_truthy
    end

    it "#{path}/Resulting document" do
      pending 'https://github.com/ONLYOFFICE/api.onlyoffice.com/issues/576' if failed_docspace_tests.include?("#{path}/Resulting document")
      expect(@documentation_page.document_exist).to be_truthy
    end
  end
end
