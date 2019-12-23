#!/bin/bash
ruby massage.rb ~/cimpl/plannet-out-11/fhir/guide
pushd ~/cimpl/plannet-out-11
rm fhir/extensions/plannet-CAvailableTime-extension.json
rm fhir/extensions/plannet-TAvailableTime-extension.json
rm fhir/extensions/plannet-IdentifierStatus-extension.json
rm fhir/extensions/plannet-TViaIntermediary-extension.json
rm fhir/extensions/plannet-GeoLocation-extension.json
rm fhir/extensions/plannet-Practitioner-Qualification-VHDIR-extension.json
rm fhir/guide/resources/structuredefinition-plannet-CAvailableTime-extension.json
rm fhir/guide/resources/structuredefinition-plannet-TAvailableTime-extension.json
rm fhir/guide/resources/structuredefinition-plannet-IdentifierStatus-extension.json
rm fhir/guide/resources/structuredefinition-plannet-TViaIntermediary-extension.json
rm fhir/guide/resources/structuredefinition-plannet-GeoLocation-extension.json
rm fhir/guide/resources/structuredefinition-plannet-Practitioner-Qualification-VHDIR-extension.json
for i in fhir/guide/resources/*.json; do sed -i .bak -f ~/git/pdex-plan-net-cimpl/renameextensions.sed $i; done
for i in fhir/profiles/*.json; do sed -i .bak -f ~/git/pdex-plan-net-cimpl/renameextensions.sed $i; done
sed -i .bak -f ~/git/pdex-plan-net-cimpl/renamevaluesets.sed fhir/guide/pages/valuesets.html
rm fhir/guide/resources/*.bak
rm fhir/profiles/*.bak
rm fhir/guide/pages/*.bak
popd

