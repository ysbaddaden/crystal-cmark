require "./common_mark"

md = CommonMark.new(File.read(ARGV[0]))

puts case ARGV[1]?
     when "xml"        then md.to_xml
     when "man"        then md.to_man
     when "commonmark" then md.to_commonmark
     when "latex"      then md.to_latex
     else                   md.to_html
     end
