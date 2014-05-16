# = Environment
# OS: Mac OS X.
# GHC: The Glorious Glasgow Haskell Compilation System, version 7.6.3
# Pandoc: 1.11.1
# Tex: BasicTex 08 July 2012
#
# = Install
#
# pandoc:
#   https://gist.github.com/repeatedly/5747244
#
# gimli (currently not used):
#   % brew install wkhtmltopdf
#   % gem install gimli
#
# = How to use (root of td-docs)
#   % ruby scripts/generate_pdf.rb
#
# Currently we use Pandoc because Pandoc support internal link and almost markdown syntax.
# But Pandoc's code highlight is poor, so we need more rich code highlight like gimli.

require 'fileutils'
require 'ostruct'

def settings
  os = OpenStruct.new
  os.root = '.'
  os
end

DOC_HOME = File.expand_path(Dir.pwd)

require "#{DOC_HOME}/lib/toc"

TMP_DIR = "#{DOC_HOME}/.tmp_docs"
ALL_TXT = "#{TMP_DIR}/all_txt.md"

Dir.mkdir(TMP_DIR) unless File.exist?(TMP_DIR)

def generate_image(path, resize = false)
  if path.start_with?('/')
    path = "./public#{path}"
  else
    # latex can't deal http so download file before
    save_path = "#{TMP_DIR}/#{File.basename(path)}"
    `wget -P #{TMP_DIR} #{path}` unless File.exist?(save_path)
    path = save_path
  end

  # latex can't convert gif file so convert to png before.
  if path.end_with?('.gif')
    `sips -s format png #{path} --out #{TMP_DIR}`
    path = "#{TMP_DIR}/#{File.basename(path)}"
    path[-3..-1] = 'png'
  end

  if resize
    path, src_path = "#{TMP_DIR}/#{File.basename(path)}", path
    FileUtils.cp(src_path, path) unless path == src_path
    `sips -Z 100 #{path}`
  end

  path
end

def get_markdown_table(orig_table, heroku = false)
  case
  when orig_table.index('If you have...')
    if heroku
    <<EOS
If you have... | Please refer to...
-------------- | ------------------
MacOS X | [Download Mac Installer](http://toolbelt.treasuredata.com/mac)
Windows | [Download Win Installer](http://toolbelt.treasuredata.com/win)
Linux | [Redhat/CentOS](http://toolbelt.treasuredata.com/redhat), [Debian/Ubuntu](http://toolbelt.treasuredata.com/debian)
Ruby gem | `gem install td`
EOS
    else
    <<EOS
If you have... | Please refer to...
-------------- | ------------------
Ubuntu System | [Installing td-agent for Debian and Ubuntu](http://docs.fluentd.org/articles/install-by-deb)
RHEL / CentOS System | [Installing td-agent for Redhat and CentOS](http://docs.fluentd.org/articles/install-by-rpm)
MacOS X | [Installing td-agent on MacOS X](http://docs.fluentd.org/articles/install-by-homebrew)
Joyent SmartOS | [Installing fluentd + td plugin on Joyent SmartOS](http://help.treasuredata.com/customer/portal/articles/1246933-installing-td-agent-on-joyent-smartos)
 AWS Elastic Beanstalk | [Installing td-agent on AWS Elastic Beanstalk](https://github.com/treasure-data/elastic-beanstalk-td-agent)
EOS
    end
  when orig_table.index('Supported Languages')
    <<EOS
+-------------------+-------------------+-------------------+
|                    Supported Languages                    |
+===================+===================+===================+
|[Ruby/Rails](#ruby)| [Java](#java)     | [Perl](#perl)     |
+-------------------+-------------------+-------------------+
| [Python](#python) | [PHP](#php)       | [Scala](#scala)   |
+-------------------+-------------------+-------------------+
| [Node.js](#nodejs)|
+-------------------+
EOS
  when orig_table.index('Basket Analysis')
    <<EOS
Name | Description
-------------- | ------------------
Basket Analysis | Analyzing POS or purchase records
[Weblog Analysis](#analyzing-apache-logs) | Calculating daily UU and PV numbers
[Twitter Analysis](#analyzing-twitter-data) | Who gets the most ReTweets for topic X?
A/B Testing | Comparing feature implementations between different sets of users
Customer | SegmentationSlice and dice your user base, and see what trends emerge
Sensor | Data AnalysisAnalysis sensor data such as smart meters
EOS
  else
    orig_table
  end
end

def fix_internal_link(line)
  line.gsub(/\[(.*?)\]\((.*?)\)/) { |match|
    if $2.start_with?('http:') or $2.start_with?('https:')
      match
    else
      # Pandoc doesn't support [foo](bar#baz) style link but
      # this link format is used in table of content in HTML rendering.
      # So remove after # string from link.
      link = $2
      link = if index = link.index('#')
               link[0...index]
             else
               link
             end
      "[#{$1}](##{link})"
    end
  }
end

def parse_include(df, f)
  in_block = false # check current line is in code block or not
  f.each_line.with_index { |line, i|
    block = line.strip
    if match = /^.*\<img.*src="(.*?)" .*\>/.match(block)
      # User logos are different size, so we should resize these images.
      path = generate_image(match[1], name == 'users')
      puts "match:", match[1]
      df.puts("![](#{path})")
      next
    elsif block.start_with?(':::')
      # Wrap source code with '```' for Pandoc highlight.
      # If need more complex configuration, then switch '```' to '~~~~{.lang}'
      # TODO: We need code block folding.
      type = block[3..-1]
      type = 'text' if (type == 'term') || (type == 'text')
      type = 'javascript' if type == 'js'

      df.puts('')
      df.puts("```#{type}")
      in_block = true
      next
    elsif line.start_with?('INCLUDE: ')
      parse_include(df, File.read("#{DOC_HOME}/docs/#{line['INCLUDE: '.length..-1].strip}.txt"))
      next
    elsif in_block && !line.empty? && line[0] != " " && line[0] != "\n"
      df.puts('```')
      df.puts
      in_block = false
    end
    line = fix_internal_link(line)

    # 4 space is not needed when use code highlight
    df.puts(in_block ? line[4..-1] : line)
  }
  df.puts("```") if in_block
  df.puts
end

excludes = ['heroku-data-import', 'td-agent-changelog']

# Pandoc's internal link can't link to arbitary section in another file.
# So, merge all files into one file.
File.open(ALL_TXT, 'w+') { |df|
  # Pandoc's cover notation
  df.puts(<<HEADER
% **Treasure Data User Manual**
% ![](./public/images/treasure-icon-red.png)
% \\newpage

\\newpage

HEADER
)

  TOC.new('en').sections.each { |_, __, categories|
    categories.each { |_, __, articles|
      articles.each { |name, title, keywords|
        next if excludes.include?(name)

        f = File.read("#{DOC_HOME}/docs/#{name}.txt")
        in_block = false # check current line is in code block or not
        table_content = nil
        f.each_line.with_index { |line, i|
          block = line.strip
          if block.start_with?('rewriterule1 message ')
            line = '      rewriterule1 message ^\\[(\\\\w+)\\] \$1.\${tag}'
            block = line.strip
          end
          if i.zero?
            line = "#{block} {##{name}}"
            if name.start_with?('hive-') # Can't convert long table into pandoc markdown, so temporary forward to web page
              df.puts('')
              df.puts("'#{name.split('-').map{|chunk| chunk.capitalize}.join(' ')}' documents are available at [docs.treasuredata.com/article/#{name}](http://docs.treasuredata.com/articles/#{name}) page")
              df.puts('')
              break
            end
          # from images included with <img> HTML tags
          elsif match = /^.*\<img.*src="(.*?)" .*\>/.match(block)
            # User logos are different size, so we should resize these images.
            path = generate_image(match[1], name == 'users')
            df.puts("![](#{path})")
            next
          # from images include with actual markup
          elsif match = /!\[(.+)\]\((.+)\)/.match(block)
            path = generate_image(match[2], name == 'users')
            df.puts("![#{match[1]}](#{path})")
            next
          elsif block.start_with?(':::')
            # Wrap source code with '```' for Pandoc highlight.
            # If need more complex configuration, then switch '```' to '~~~~{.lang}'
            # TODO: We need code block folding.
            type = block[3..-1]
            type = 'text' if (type == 'term') || (type == 'text')
            type = 'javascript' if type == 'js'

            df.puts('')
            df.puts("```#{type}")
            in_block = true
            next
          elsif line.start_with?('INCLUDE: ')
            parse_include(df, File.read("#{DOC_HOME}/docs/#{line['INCLUDE: '.length..-1].strip}.txt"))
            next
          elsif in_block && !line.empty? && line[0] != " " && line[0] != "\n"
            df.puts('```')
            df.puts
            in_block = false
          elsif line.start_with?('<table>')
            table_content = ''
            next
          elsif line.start_with?('</table>')
            table_content << line
            df.puts('')
            df.puts(get_markdown_table(table_content, name.start_with?('heroku-')))
            df.puts('')
            table_content = nil
            next
          elsif table_content
            table_content << line
            next
          end
          line = fix_internal_link(line)

          # sanitize a few things that pandoc does not like
          # escape \N to \\N
          line = line.gsub(/\N/, "\\N") if line =~ /\\N/
          # escape \n to \\n
          line = line.gsub(/\\n/, "\\\\\\\\n") if line =~ /\\n/

          # 4 space is not needed when use code highlight
          df.puts(in_block ? line[4..-1] : line)
        }
        df.puts("```") if in_block
        df.puts
      }
    }
  }
}

puts "Writing output to '#{DOC_HOME}/td-docs.pdf'"
`pandoc -f markdown #{ALL_TXT} --latex-engine=xelatex -V geometry:margin=1in --toc -s -o #{DOC_HOME}/td-docs.pdf`
