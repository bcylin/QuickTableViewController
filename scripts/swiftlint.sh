#!/bin/sh

if [ -z "${TRAVIS}"]; then
  ${PODS_ROOT}/SwiftLint/swiftlint --config .swiftlint.yml
else
  echo "Skip SwiftLint"
fi
