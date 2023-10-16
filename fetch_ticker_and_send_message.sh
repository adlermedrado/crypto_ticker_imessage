#!/usr/bin/env bash

URL="https://api.mercadobitcoin.net/api/v4/tickers"
SYMBOLS=$1
DESTINATION=$2

RESPONSE=$(curl -s "$URL?symbols=$SYMBOLS")

if [ -z "$RESPONSE" ]; then
  echo "No data received from the API."
  exit 1
fi

FORMATTED_DATA=$(echo "$RESPONSE" | jq '.[] | "\(.pair) -  High: \(.high), Low: \(.low), Buy: \(.buy), Sell: \(.sell), Last: \(.last)"')


# Uncomment below if yout want to send iMessage using apple shortcuts
# CURRENT_DATE=$(date +%s)
# FILE_NAME="/tmp/${CURRENT_DATE}.txt"
# echo "$FORMATTED_DATA" >> "$FILE_NAME"
# $(shortcuts run "Send Crypto Tickers" -i "$FILE_NAME")

# Comment below if you are using apple shortcuts
osascript message.applescript "$DESTINATION" "$FORMATTED_DATA"
