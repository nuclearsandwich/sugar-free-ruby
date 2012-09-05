require "yaml"
require_relative "blogdown"

class Post
  attr_reader :filename, :content, :metadata

  def initialize filename
    @filename = filename
    read_file
  end

  def read_file
    content = File.read filename
    if md = content.match(/^(---\s*\n.*?\n?)^(---\s*$\n?)/m)
      @content = md.post_match
      @metadata = YAML.load md[0]
    end
  end

  def html_content
    <<-HTML
<article>
  <header>
    <h1>#{title}</h1>
    <h2>published: #{date.strftime "%e %b %Y %I:%m:%S%p"}</h2>
  </header>
  #{Blogdown.parser.render @content}
</article>
    HTML
  end

  def html_filename
    "#{File.basename(@filename).split('.').first}.html"
  end
  def method_missing sym, *args, &block
    if @metadata.has_key? sym.to_s
      @metadata[sym.to_s]
    else
      super
    end
  end

  def respond_to?
    @metadata.has_key?(sym.to_s) || super
  end

  def published?
    @metadata.fetch "published", true
  end
end
