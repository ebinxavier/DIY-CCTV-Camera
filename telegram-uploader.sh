#!/bin/bash

# Replace with your Telegram bot token and chat ID
BOT_TOKEN="<BOT_TOKEN>"
CHAT_ID="<CHAT_ID>"


# Check if both command-line arguments are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <VIDEO_PATH> <CAPTION>"
  exit 1
fi

# Get command-line arguments
VIDEO_PATH="$1"
CAPTION="$2"

# Check if the video file exists
if [ ! -f "$VIDEO_PATH" ]; then
  echo "Error: Video file not found at $VIDEO_PATH"
  exit 1
fi

# Define the Telegram API URL
TELEGRAM_API_URL="https://api.telegram.org/bot$BOT_TOKEN/sendVideo"

# # Upload the video to Telegram along with the caption using cURL
# curl -F "chat_id=$CHAT_ID" -F "video=@$VIDEO_PATH" -F "caption=$CAPTION" "$TELEGRAM_API_URL"

# Upload the video to Telegram along with the caption using cURL
response=$(curl -s -F "chat_id=$CHAT_ID" -F "video=@$VIDEO_PATH" -F "caption=$CAPTION" "$TELEGRAM_API_URL")


# Check the response from Telegram
if [ -z "$response" ]; then
  echo "Error: Failed to send video to Telegram"
  exit 1
else
  # Check if the ok key in the response is true to determine success
  if grep -q ok:true <<< "$response"; then
    echo "Video sent to Telegram successfully. Response: $response"
  else
    echo "Error: Failed to send video to Telegram. Response: $response"
    exit 1
  fi
fi
