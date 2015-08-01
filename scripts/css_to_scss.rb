mapping = {}

require 'csv'

CSV.foreach("scripts/color_mapping.csv") do |row|
  mapping[row[0]] = row[2]
end

puts '@import "color.scss";'

def search_and_replace(line, mapping)
  line.scan(/#[a-fA-F0-9]{6}/).each do |m|
    if mapping[m.upcase]
      line.gsub!(m, '$'+mapping[m.upcase])
    end
  end
  line.scan(/#[a-fA-F0-9]{3}/).each do |m|
    if mapping[m.upcase]
      line.gsub!(m, '$'+mapping[m.upcase])
    end
  end
  puts line
end

f = File.new(ARGV[0])

f.each_line do |line|
  search_and_replace(line, mapping) 
end

f.close
