# frozen_string_literal: true

module TestingApiOnlyOfficeCom
  # class for editing class names
  # https://user-images.githubusercontent.com/40513035/57938547-0fcb7200-78d1-11e9-800f-e685243246d2.png
  # /docbuilder/basic
  module CheckMethodLinks
    # TODO: simplify the method
    def check_documentation_links(objects, parsed_json)
      checked = {}
      parsed_json.each_with_index do |(module_name, section_hash), index|
        checked[module_name] = objects[index].visible?
        @instance.webdriver.webdriver_error("Not visible element: #{module_name}") unless checked[module_name]
        objects[index].click_expend
        section_hash.each do |section_name, methods_array|
          OnlyofficeLoggerHelper.log("Checking #{objects[index].name}/#{section_name}")
          unless section_name.include? 'unspecified'
            checked[section_name] = objects[index][section_name].visible?
            @instance.webdriver.webdriver_error("Not visible element: #{module_name}/#{section_name}") unless checked[section_name]
            objects[index][section_name].click_expend
          end
          if objects[index][section_name].child_count_on_page == methods_array.length
            methods_array.each do |method_name|
              OnlyofficeLoggerHelper.log(method_name)
              checked[method_name] = objects[index][section_name][method_name].visible?
            end
          else
            @instance.webdriver.webdriver_error("Incorrect child count on page: #{module_name}/#{section_name}\n" \
                                                "In data: #{methods_array.length}.\n" \
                                                "On page: #{objects[index][section_name].child_count_on_page}")
          end
        end
      end
      checked.find_all { |_key, value| !value }
    end
  end
end
