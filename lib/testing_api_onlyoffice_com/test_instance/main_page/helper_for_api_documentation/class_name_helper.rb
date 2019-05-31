# frozen_string_literal: true

module TestingApiOnlyfficeCom
  # class for editing class names
  # https://user-images.githubusercontent.com/40513035/57938547-0fcb7200-78d1-11e9-800f-e685243246d2.png
  # /docbuilder/basic
  class ClassNameHelper
    def self.cleanup_name(name)
      name.downcase.tr_s(' ', '')
    end
  end
end
