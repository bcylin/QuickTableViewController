#!/usr/bin/env ruby

# Sometimes it's a README fix, or something like that - which isn't relevant for
# including in a project's CHANGELOG for example
declared_trivial = pr_title.include? "#trivial"

# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if pr_title.include? "[WIP]"

# Warn when there is a big PR
warn("Big PR") if lines_of_code > 500

# Don't let testing shortcuts get into master by accident
fail("fdescribe left in tests") if `grep -r fdescribe specs/`.length > 1
fail("fit left in tests") if `grep -r "fit specs/ `.length > 1

# Add a CHANGELOG entry for app changes
if git.lines_of_code > 50 && !github.modified_files.include?("CHANGELOG.md") && !declared_trivial
  fail("Please include a CHANGELOG entry. \nYou can find it at [CHANGELOG.md](https://github.com/bcylin/QuickTableViewController/blob/develop/CHANGELOG.md).")
end

# Ensure a clean commits history
if git.commits.any? { |c| c.message =~ /^Merge branch '#{github.branch_for_base}'/ }
  fail('Please rebase to get rid of the merge commits in this PR')
end
