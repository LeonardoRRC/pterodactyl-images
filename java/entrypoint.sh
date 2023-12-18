#!/bin/bash

TZ=${TZ:-UTC}
export TZ

INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

cd /home/container || exit 1

echo "Java version:"
java -version

PARSED=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")
echo "Parsed startup command: $PARSED"

JAR_PATH=$(echo "$PARSED" | grep -oP '(\S+\.jar)')

if [ -n "$JAR_PATH" ] && file "$JAR_PATH" | grep -q "Java archive data (JAR)"; then
    echo "Starting Java application..."
    exec env ${PARSED}
else
    echo "Invalid file type for JAR, or file is not a Java JAR. Cancelling execution..."
    exit 1
fi
