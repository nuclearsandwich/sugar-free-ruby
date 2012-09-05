require "redcarpet"
require "pygments"

module Blogdown
  class HTMLConPygments < Redcarpet::Render::HTML
    def block_code code, lang
      Pygments.highlight code, :lexer => lang
    end
  end

  def parser
    @parser ||= Redcarpet::Markdown.new HTMLConPygments, :fenced_code_blocks => true,
      :no_intra_emphasis => true
  end
  module_function :parser
end
