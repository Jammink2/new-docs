  Encoding.default_external = Encoding.default_internal = 'utf-8'

require 'rdiscount'
require 'sanitize'

class Article
  def text_only
    @body = @body.gsub(/\<[^\<]+\>/,'')
    self
  end

  def self.load(topic, source)
    topic = new(topic, source)
    topic.parse
    return topic
  end

  attr_reader :topic, :title, :desc, :content, :toc, :intro, :body

  def initialize(name, source)
    @topic = name
    @source = source
  end

  def parse
    @topic = topic
    @content = markdown(source)
    @title, @content = _title(@content)
    @desc = _desc(@content)
    @toc, @content = _toc(@content)
    if @toc.any?
      # split at the first occurrence of the <h2> marking the division between
      #   the paragraph and the beginning of the article
      @content.sub!(/(<a name=".+"><\/a><h2>)/, '<REMOVEME>\1')
      @intro, @body = @content.split('<REMOVEME>', 2)
      puts
      @body = "#{@body}" # add the <h2> tag back
    else
      @intro, @body = '', @content
    end
  end

  protected

  def source
    @source
  end

  def notes(source)
    source.gsub(
                /NOTE: (.*?)\n\n/m,
                "<table class='note'>\n<td class='icon'></td><td class='content'>\\1</td>\n</table>\n\n"
    )
  end

  def markdown(source)
    html = RDiscount.new(notes(source), :smart).to_html
    # parse custom {lang} definitions to support syntax highlighting
    html.gsub(/<pre><code>\{(\w+)\}/, '<pre><code class="brush: \1;">')
  end

  def topic_file(topic)
    if topic.include?('/')
      topic
    else
      "#{options.root}/docs/#{topic}.txt"
    end
  end

  def _title(content)
    title = content.match(/<h1>(.*)<\/h1>/)[1]
    content_minus_title = content.gsub(/<h1>.*<\/h1>/, '')
    return title, content_minus_title
  end

  def _desc(content)
    desc = Sanitize.clean(content.match(/<p>(.*)<\/p>/)[1])
    return desc
  end

  def slugify(title)
    title.downcase.gsub(/[^a-z0-9 -]/, '').gsub(/ /, '-')
  end

  def _toc(content)
    anchors = []
    toc = content.scan(/<h([23])>(.+?)<\/h\1>/m).to_a.map.with_index do |(l, hx), i|
      anchor = slugify(hx.gsub(/<(.+?)>/, ''))
      if anchors.include?(anchor)
        anchor += "_#{i}"
      end
      anchors << anchor
      [l, hx, anchor]
    end
    i = 0
    content_with_anchors = content.gsub(/<h([23])>(.+?)<\/h\1>/m) do |hx|
      content = "<a name=\"#{anchors[i]}\"></a>#{hx}"
      i += 1
      content
    end
    # puts "toc:                  #{toc}"
    # puts "contentntent_with_anchors: #{content_with_anchors}"
    return toc, content_with_anchors
  end
end
