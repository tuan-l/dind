#!/bin/sh
echo $PRODUCTION

if [ "$PRODUCTION" = true ]; then
    echo "Running in production mode..."
    yarn run build
    yarn run start
else
    echo "Running in development mode..."
    yarn run dev
fi
