#!/usr/bin/env ruby

require "bundler/setup"
require "octokit"

token = ENV["DANGER_GITHUB_API_TOKEN"]
repo = "bcylin/QuickTableViewController"
branch = "gh-pages"
commit = %x(git --no-pager log -1 --pretty="%H")

unless token
	puts "Missing DANGER_GITHUB_API_TOKEN"
	puts "Abort " + %x(git --no-pager log -1 --pretty="%H %s [%an]").strip
	exit 1
end

github = Octokit::Client.new(access_token: token)
puts github.update_ref(repo, branch, commit)
