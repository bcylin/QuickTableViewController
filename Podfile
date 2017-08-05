platform :ios, "8.0"
use_frameworks!

workspace "QuickTableViewController"

target "QuickTableViewControllerTests-iOS" do
  project "QuickTableViewController"
  pod "Nimble", git: "https://github.com/Quick/Nimble.git", tag: "v6.1.0"
  pod "Quick", git: "https://github.com/Quick/Quick.git", tag: "v1.1.0"
end

target :Example do
  project "Example"
  pod "QuickTableViewController", path: "./"
  pod "SwiftLint", "0.19.0"
  pod "Weakify", git: "https://github.com/klundberg/Weakify.git", tag: "v0.4.0"
end
