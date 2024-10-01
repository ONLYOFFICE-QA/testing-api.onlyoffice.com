# frozen_string_literal: true

# module
module ChapterNavParser
  def chapter_nav_hrefs(page_source = @page_source,
                        xpath_chapter_nav = @xpath_chapter_nav)
    document = Nokogiri::HTML(page_source)
    parent_node = document.at_xpath(xpath_chapter_nav)
    pre_order(parent_node, 'href')

    @attrs
  end

  def pre_order(node, attr)
    @attrs = [] if @attrs.nil?
    return @attrs unless node.children.any?

    @attrs&.push(node[attr]) unless node[attr].nil?

    node.children.each do |child|
      pre_order(child, attr)
    end
  end
end
