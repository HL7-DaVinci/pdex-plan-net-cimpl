require 'json'
require 'nokogiri'

if ARGV.length < 1
  puts "Too few arguments.  First argument should be targetpath."
  exit
end
 
puts "Working on #{ARGV}";



TARGET_PATH = ARGV[0]
IG_JSON_FILENAME = "#{TARGET_PATH}" + "/ig.json"
IG_XML_FILENAME = "#{TARGET_PATH}" + "/resources/ig.xml"
EXTENSION_HTML_FILENAME = "#{TARGET_PATH}" + "/pages/extensions.html"

puts "Target Path #{TARGET_PATH}"
structure_definitions_to_remove = [
  'StructureDefinition/plannet-CAvailableTime-extension',
  'StructureDefinition/plannet-TAvailableTime-extension',
  'StructureDefinition/plannet-TViaIntermediary-extension',
  'StructureDefinition/plannet-GeoLocation-extension',
  'StructureDefinition/plannet-IdentifierStatus-extension',
  'StructureDefinition/plannet-Proficiency-extension',
  'StructureDefinition/plannet-AllDay-extension',
  'StructureDefinition/plannet-AvailableEndTime-extension',
  'StructureDefinition/plannet-AvailableStartTime-extension',
  'StructureDefinition/plannet-DaysOfWeek-extension',
  'StructureDefinition/plannet-Practitioner-Qualification-VHDIR-extension'
]

# Fix ig.json
#ig_json = JSON.parse(File.read(IG_JSON_FILENAME))
#resources = ig_json['resources'].reject { |resource, _| structure_definitions_to_remove.include? resource }
#ig_json['resources'] = resources
#ig_json['dependencyList'] << {
#  package: 'hl7.fhir.uv.vhdir',
#  version: 'current',
#  name: 'VhDir',
#  location: 'http://build.fhir.org/ig/HL7/VhDir/'
#}
#File.write(IG_JSON_FILENAME, JSON.pretty_generate(ig_json, indent: '  '))

# Fix ig.xml
ig_xml = Nokogiri::XML(File.read(IG_XML_FILENAME))
ig_xml.css('resource')
  .select do |resource|
    structure_definitions_to_remove.include? resource.css('reference reference').attribute('value').value
  end.each { |resource| resource.remove }
File.write(IG_XML_FILENAME, ig_xml.to_xml)

# Fix extensions.html
html_definitions_to_remove = structure_definitions_to_remove.map { |definition| definition.tr('/', '-') }
html_file = File.open(EXTENSION_HTML_FILENAME)
extensions_html = html_file.read
html_file.close
line_number = 0
extension_line_numbers = []
extensions_html.each_line do |line|
  if html_definitions_to_remove.any? { |definition| line.include? definition }
    extension_line_numbers << line_number
  end
  line_number += 1
end

line_numbers_to_remove = extension_line_numbers.flat_map do |line_number|
  first_line = line_number - 1
  last_line = line_number + 2
  (first_line..last_line).to_a
end

File.open(EXTENSION_HTML_FILENAME, 'w') do |file|
  line_number = 0
  extensions_html.each_line do |line|
    if line_numbers_to_remove.include? line_number
      line_number += 1
      next
    end
    file.puts line
    line_number += 1
  end
end