module TestingApiOnlyfficeCom
  # https://user-images.githubusercontent.com/40513035/56642044-4c63cf00-667f-11e9-935f-0d275d601876.png
  # /docbuilder/basic
  class DocumentEntry
    attr_accessor :link, :xpath, :xpath_expend, :children

    def initialize(instance, link)
      @instance = instance
      @link = link
      @xpath = "//*[contains(@href, '#{link}')]"
      @xpath_expend = "(#{@xpath}/parent::li)[1]/div"
      @children = []
    end
  end
end
