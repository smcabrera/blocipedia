class Wiki < ActiveRecord::Base
  belongs_to :user
  validates :user, presence: true

  def markdown_to_html(text)
    renderer = Redcarpet::Render::HTML.new
    extensions = { fenced_code_blocks: true }
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    redcarpet.render(text).html_safe
  end
end
