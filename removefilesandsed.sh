#!/bin/bash
ruby massage.rb ../plannet-out10/fhir/guide
cd ../plannet-out10
rm fhir/extensions/plannet-CAvailableTime-extension.json
rm fhir/extensions/plannet-TAvailableTime-extension.json
rm fhir/extensions/plannet-IdentifierStatus-extension.json
rm fhir/extensions/plannet-Proficiency-extension.json
rm fhir/extensions/plannet-TViaIntermediary-extension.json
rm fhir/extensions/plannet-GeoLocation-extension.json
rm fhir/extensions/plannet-AllDay-extension.json
rm fhir/extensions/plannet-AvailableEndTime-extension.json
rm fhir/extensions/plannet-AvailableStartTime-extension.json
rm fhir/extensions/plannet-DaysOfWeek-extension.json
rm fhir/extension/plannet-Qualification-extension.json
rm fhir/extension/plannet-Practitioner-Qualification-VHDIR-extension.json
rm fhir/guide/resources/structuredefinition-plannet-CAvailableTime-extension.json
rm fhir/guide/resources/structuredefinition-plannet-TAvailableTime-extension.json
rm fhir/guide/resources/structuredefinition-plannet-IdentifierStatus-extension.json
rm fhir/guide/resources/structuredefinition-plannet-TViaIntermediary-extension.json
rm fhir/guide/resources/structuredefinition-plannet-Proficiency-extension.json
rm fhir/guide/resources/structuredefinition-plannet-GeoLocation-extension.json
rm fhir/guide/resources/structuredefinition-plannet-AllDay-extension.json
rm fhir/guide/resources/structuredefinition-plannet-AvailableEndTime-extension.json
rm fhir/guide/resources/structuredefinition-plannet-AvailableStartTime-extension.json
rm fhir/guide/resources/structuredefinition-plannet-DaysOfWeek-extension.json
rm fhir/guide/resources/structuredefinition-plannet-Practitioner-Qualification-VHDIR-extension.json
for i in fhir/guide/resources/structuredefinition-plannet-*.json; do sed -i .bak -f ~/cimpl/davinci-pdex-plan-net/renameextensions.sed $i; done
sed -i .bak -f ~/cimpl/davinci-pdex-plan-net/renamevaluesets.sed fhir/guide/pages/valuesets.html
cd ../davinci-pdex-plan-net

