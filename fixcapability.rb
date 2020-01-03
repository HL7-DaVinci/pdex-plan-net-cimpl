require 'json'
require 'nokogiri'
require 'pry'

if ARGV.length < 1
  puts "Too few arguments.  First argument should be targetpath."
  exit
end
 
puts "Working on #{ARGV}";

resources_to_remove = [
  'VerificationResult',
  'CareTeam',
  'Consent'
]

# 7 Resources to keep:
# Endpoint
# HealthcareService
# Location
# Organization (2 profiles:  Network and Organization)
# OrganizationAffiliation
# Practitioner
# PractitionerRole

# 3 Resources to get rid of
# VerificationResult
# CareTeam
# Consent



TARGET_PATH = ARGV[0]
CAPABILITY_FILENAME = "#{TARGET_PATH}" + "/searchParameters_plannet/CapabilityStatement-plannet-server.json"

# Fix capability.json
capability = JSON.parse(File.read(CAPABILITY_FILENAME))
binding.pry
resources = capability['rest'][0]['resource'].reject { |resource, _| resources_to_remove.include? resource["type"] }
capability['rest'][0]['resource'] = resources
File.write(CAPABILITY_FILENAME, JSON.pretty_generate(capability, indent: '  '))

