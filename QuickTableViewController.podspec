Pod::Spec.new do |s|
  s.name          = "QuickTableViewController"
  s.version       = "1.2.3"
  s.summary       = "A simple way to create a UITableView for settings."
  s.screenshots   = "https://raw.githubusercontent.com/bcylin/QuickTableViewController/gh-pages/img/screenshot-1.png",
                    "https://raw.githubusercontent.com/bcylin/QuickTableViewController/gh-pages/img/screenshot-2.png"
  s.homepage      = "https://github.com/bcylin/QuickTableViewController"
  s.license       = { type: "MIT", file: "LICENSE" }
  s.author        = "bcylin"

  s.swift_version           = "5"
  s.ios.deployment_target   = "8.0"
  s.tvos.deployment_target  = "9.0"

  s.source        = { git: "https://github.com/bcylin/QuickTableViewController.git", tag: "v#{s.version}" }
  s.source_files  = "Source/**/*.swift"
  s.requires_arc  = true
end
