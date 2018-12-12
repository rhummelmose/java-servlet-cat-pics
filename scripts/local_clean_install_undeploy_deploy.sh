#!/bin/bash

if [ -z "${JSCP_LOCAL_MANAGER_URL}" ]; then
  # Cancel deployment as we have no target local manager URL
  echo "Cancelling deploymeent as no target local manager URL was found."
  exit 0
fi

if [ -z "${JSCP_LOCAL_SERVER_NAME}" ]; then
  # Cancel deployment as we have no target local server name
  echo "Cancelling deploymeent as no target local server name was found."
  exit 0
fi

cp pom.xml pom.xml.backup

sed -i "" -e "s|{JSCP_LOCAL_MANAGER_URL}|${JSCP_LOCAL_MANAGER_URL}|g" pom.xml
sed -i "" -e "s|{JSCP_LOCAL_SERVER_NAME}|${JSCP_LOCAL_SERVER_NAME}|g" pom.xml

mvn clean
mvn install
mvn tomcat7:undeploy
mvn tomcat7:deploy

rm pom.xml
mv pom.xml.backup pom.xml
