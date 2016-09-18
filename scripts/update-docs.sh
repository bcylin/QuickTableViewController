#!/bin/sh

files=(html css js json)

for file in "${files[@]}"
do
  echo "Cleaning whitespace in *.$file"
  find docs/output -name "*."$file -exec sed -E -i '' -e 's/[[:blank:]]*$//' {} \;
done


cd docs && pwd
git checkout gh-pages
git status
cp -rfv output/* .
git --no-pager diff --stat
git add .
git commit -m "[CI] Update documentation at $(date +'%Y-%m-%d %H:%M:%S %z')"
bundle exec ruby ../scripts/push-gh-pages.rb
cd -
