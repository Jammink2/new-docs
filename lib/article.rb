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
      @intro, @body = @content.split('<h2>', 2)
      @body = "<h2>#{@body}" # add the <h2> tag back
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
    toc = content.scan(/<h([23])>(.+?)<\/h\1>/m).to_a.map.with_index do |(l, hx), i|
      [l, hx, slugify(hx.gsub(/<(.+?)>/, '')) + "_#{i}"]
    end
    puts content.gsub(/<h([23])>(.+?)<\/h\1>/m).class
    i = 0
    content_with_anchors = content.gsub(/<h([23])>(.+?)<\/h\1>/m) do |hx|
      content = "<a name=\"#{slugify(hx.gsub(/<(.+?)>/, '')) + "_#{i}"}\"></a>#{hx}"
      i += 1
      content
    end
    puts "toc:                  #{toc}"
    puts "content_with_anchors: #{content_with_anchors}"
    return toc, content_with_anchors
  end

  def _toc2(content)
    index = 0

    toc2 = content.scan(/<h2>(.+?)<\/h2>/m).to_a.map { |m| m[0] }
    toc2_anchors = []
    content_with_anchors = content.gsub(/(<h2>(.+?)<\/h2>)/m) do |h2|
      index += 1
      anchor = slugify(h2.gsub(/<.+?>/, '')) + "_#{index}"
      toc2_anchors << anchor
      "<a name=\"#{anchor}\"></a>#{h2}"
    end
    puts "toc2         #{toc2}"
    puts "toc2_anchors #{toc2_anchors}"
    # puts "content_with_anchors #{content_with_anchors}"

    toc3 = content.scan(/<h3>(.+?)<\/h3>/m).to_a.map { |m| m[0] }
    toc3_anchors = []
    content_with_anchors = content_with_anchors.gsub(/(<h3>(.+?)<\/h3>)/m) do |h3|
      index += 1
      anchor = slugify(h3.gsub(/<.+?>/, '')) + "_#{index}"
      toc3_anchors << anchor
      "<a name=\"#{anchor}\"></a>#{h3}"
    end
    puts "toc3         #{toc3}"
    puts "toc3_anchors #{toc3_anchors}"
    # puts "content_with_anchors #{content_with_anchors}"

    toc_with_levels = []
    content_with_anchors.split(/\n/).each {|line|
      # puts "looking at '#{line}"
      toc2.each {|title|
        if line =~ /<h2>#{Regexp.escape(title)}<\/h2>/
          toc_with_levels << ["2", title.gsub(/<.+?>/, '')]
        end
      }
      toc3.each {|title|
        if line =~ /<h3>#{Regexp.escape(title)}<\/h3>/
          toc_with_levels << ["3", title.gsub(/<.+?>/, '')]
        end
      }
    }
    # puts "toc_with_levels #{toc_with_levels}"
    return toc_with_levels, content_with_anchors
  end
end
