#!/bin/sh

export PATH="$PATH:/opt/homebrew/bin"

if [ -n "$CI" ]; then
  echo "CI=$CI, skip SwiftLint"
elif which mint > /dev/null; then
  mint run realm/SwiftLint --fix && mint run realm/SwiftLint
else
  echo "Install 'mint' (https://github.com/yonaskolb/Mint) to run SwiftLint"
fi
