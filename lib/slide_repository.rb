class SlideRepository
  include Enumerable
  def initialize directory, skip_drafts = false
    @skip_drafts = skip_drafts

    @directory = case directory
                 when String
                   Dir.new directory
                 else
                   directory
                 end
    process
  end

  def process
    slide_count = 0
    @slides = @directory.map do |post_file|
      next unless post_file =~ /\.(md|markdown)$/
      pathname = File.join @directory.path, post_file
      Slide.new pathname
    end

    @slides.select! { |s| s }
    if @skip_drafts
      @slides.select! &:published?
    end
    @slides.sort_by!(&:rank)
    @slides.each_with_index do |s, i|
      s.x ||= 2000 * i
      s.y ||= 0
    end
  end

  def each *args, &block
    @slides.each *args, &block
  end

  def index_content
    builder = ""
    each do |post|
      builder << <<-HTML
<div class="article-link">
  <h1><a href="/blog/#{post.html_filename}">#{post.title}</a></h1>
  <h2>Published: #{post.date.strftime "%B %Y"}</h2>
</div>
HTML
    end
    builder
  end
end

