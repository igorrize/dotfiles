#!/bin/bash
raw=$(/usr/bin/defaults read /Users/igorlobazov/Library/Preferences/com.apple.HIToolbox.plist \
  AppleCurrentKeyboardLayoutInputSourceID 2>/dev/null \
  | /usr/bin/awk -F. '{print $NF}')
case "$raw" in
  ABC|US|"U.S.")  echo "EN" ;;
  Russian)        echo "RU" ;;
  Ukrainian)      echo "UA" ;;
  *)              echo "${raw:0:2}" | /usr/bin/tr '[:lower:]' '[:upper:]' ;;
esac
