#!/bin/bash

set -e

host=$1
port=$2

if [[ "$host" == "" || "$port" == "" ]]; then
    echo "Usage: $0 host port"
    exit 1
fi

while ! nc -vz $host $port; do
  sleep 1
done