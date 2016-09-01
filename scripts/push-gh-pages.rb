#!/usr/bin/env ruby

puts %x(git --no-pager log -1 --pretty="%H %d %s [%an]")
