# frozen_string_literal: true

require 'spec_helper'

describe 'describe' do
  let(:dummy_class) { Class.new { extend ChapterNavParser } }
  let(:source_path) { File.read("#{Dir.pwd}/unit/assets/page_source.html") }

  it 'test' do
    hrefs = dummy_class.chapter_nav_hrefs(source_path, "*//o-chapter-nav[@class='tree']")
    expect(hrefs).to be_instance_of(Array)
    expect(hrefs.length).to eq(13)
    expect(hrefs).to include('/docspace/javascript-sdk/get-started/',
                             '/docspace/javascript-sdk/javascript-sdk/initialization-modes/file-selector/',
                             '/docspace/javascript-sdk/javascript-sdk/events/')
  end
end
