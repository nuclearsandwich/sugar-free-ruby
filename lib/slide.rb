require "yaml"
require_relative "blogdown"

class Slide
  attr_reader :filename, :content, :metadata
  attr_accessor :x, :y

  def initialize filename
    @filename = filename
    read_file
    x = @metadata['x']
    y = @metadata['y']
  end

  def read_file
    content = File.read filename
    if md = content.match(/^(---\s*\n.*?\n?)^(---\s*$\n?)/m)
      @content = md.post_match
      @metadata = YAML.load md[0]
    else
      @content = content
      @metadata = {}
    end
  end

  def html_content
    <<-HTML
<div class="#{classes}" id=#{id} data-x="#{x}" data-y="#{y}">
  #{Blogdown.parser.render @content}
</div>
    HTML
  end

  def method_missing sym, *args, &block
    if @metadata.has_key? sym.to_s
      @metadata[sym.to_s]
    else
      super
    end
  end

  def id
    @metadata.fetch "id", "slide-#{rank}"
  end

  def respond_to?
    @metadata.has_key?(sym.to_s) || super
  end

  def classes
    @metadata.fetch('classes','') + ' step slide'
  end
end
