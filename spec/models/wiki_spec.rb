require 'rails_helper'

RSpec.describe Wiki, type: :model do
  describe "#markdown_to_html" do
    it "returns markdown text as html" do
      text = "This is some *interesting* text"
      html = "<p>This is some <em>interesting</em> text</p>\n"
      expect(markdown_to_html(text)).to eq(html)
    end
  end
end
