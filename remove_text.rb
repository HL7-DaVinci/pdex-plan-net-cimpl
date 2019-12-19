require 'json'
require 'nokogiri'

if ARGV.length < 1
  puts "Too few arguments.  First/only argument should be Path to searchParameter file."
  exit
end
 


SP_JSON_FILENAME = ARGV[0]
SP_JSON_FILENAME_BAK = "#{SP_JSON_FILENAME}" + ".bak"
SP_JSON_FILENAME_NEW = "#{SP_JSON_FILENAME}" 

puts "Reading #{SP_JSON_FILENAME}"
SP_json = JSON.parse(File.read(SP_JSON_FILENAME))
File.write(SP_JSON_FILENAME_BAK, JSON.pretty_generate(SP_json, indent: '  '))
puts "Wrote #{SP_JSON_FILENAME_BAK}"
newSP_json = SP_json.reject { |field, _| field.eql?( "text") }
File.write(SP_JSON_FILENAME_NEW, JSON.pretty_generate(newSP_json, indent: '  '))
