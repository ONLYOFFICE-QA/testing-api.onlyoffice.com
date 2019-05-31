require_relative 'document_entry'
module TestingApiOnlyfficeCom
  # class for editing class names
  # https://user-images.githubusercontent.com/40513035/57938547-0fcb7200-78d1-11e9-800f-e685243246d2.png
  # /docbuilder/basic
  module CheckMethodLinks
    def check_documentation_links(documentation_objects, parsed_json)
      checked = {}
      parsed_json.each_with_index do |(module_name, section_hash), index|
        checked[module_name] = documentation_objects[index].visible?
        documentation_objects[index].click_expend
        section_hash.each do |section_name, methods_array|
          unless section_name == 'unspecified'
            checked[section_name] = documentation_objects[index][section_name].visible?
            documentation_objects[index][section_name].click_expend
          end
          methods_array.each do |method_name|
            checked[method_name] = documentation_objects[index][section_name][method_name].visible?
          end
        end
      end
      checked.find_all { |_key, value| !value }
    end
  end
end
