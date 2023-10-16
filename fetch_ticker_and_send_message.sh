#!/usr/bin/env bash

URL="https://api.mercadobitcoin.net/api/v4/tickers"
SYMBOLS=$1
DESTINATION=$2

RESPONSE=$(curl -s "$URL?symbols=$SYMBOLS")

if [ -z "$RESPONSE" ]; then
  echo "No data received from the API."
  exit 1
fi

FORMATTED_DATA=$(echo "$RESPONSE" | jq '.[] | "\(.pair) -  High: \(.high) Low: \(.low) Buy: \(.buy) Sell: \(.sell) Last: \(.last)"')

echo "$FORMATTED_DATA"
osascript message.applescript "$DESTINATION" "$FORMATTED_DATA"