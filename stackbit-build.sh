#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://api.stackbit.com/project/5e81cee0cdedc6001b9d3bd1/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://api.stackbit.com/pull/5e81cee0cdedc6001b9d3bd1 
fi
curl -s -X POST https://api.stackbit.com/project/5e81cee0cdedc6001b9d3bd1/webhook/build/ssgbuild > /dev/null
gatsby build
./inject-netlify-identity-widget.js public
curl -s -X POST https://api.stackbit.com/project/5e81cee0cdedc6001b9d3bd1/webhook/build/publish > /dev/null
