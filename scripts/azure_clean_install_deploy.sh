#!/bin/bash

if [ -z "${JSCP_AZURE_RESOURCE_GROUP_NAME}" ]; then
  # Cancel deployment as we have no target Azure resource group
  echo "Cancelling deploymeent as no target Azure resource group was found."
  exit 0
fi

if [ -z "${JSCP_AZURE_APP_SERVICE_NAME}" ]; then
  # Cancel deployment as we have no target Azure app service
  echo "Cancelling deploymeent as no target Azure app service was found."
  exit 0
fi

cp pom.xml pom.xml.backup

sed -i "" -e "s|{JSCP_AZURE_RESOURCE_GROUP_NAME}|${JSCP_AZURE_RESOURCE_GROUP_NAME}|g" pom.xml
sed -i "" -e "s|{JSCP_AZURE_APP_SERVICE_NAME}|${JSCP_AZURE_APP_SERVICE_NAME}|g" pom.xml

mvn clean
mvn install
mvn azure-webapp:deploy

rm pom.xml
mv pom.xml.backup pom.xml
