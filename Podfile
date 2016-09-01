platform :ios, "8.0"
use_frameworks!

workspace "QuickTableViewController"

target "QuickTableViewControllerTests-iOS" do
  project "QuickTableViewController"
  pod "Nimble"
  pod "Quick"
end

target :Example do
  project "Example/Example"
  pod "QuickTableViewController", path: "./"
end
