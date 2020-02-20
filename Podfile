install! "cocoapods", generate_multiple_pod_projects: true
inhibit_all_warnings!
use_frameworks!

workspace "QuickTableViewController"
project "QuickTableViewController"

def linter
  pod "SwiftLint", podspec: "https://raw.githubusercontent.com/CocoaPods/Specs/master/Specs/4/0/1/SwiftLint/0.32.0/SwiftLint.podspec.json"
end

target "QuickTableViewController-iOSTests" do
  platform :ios, "8.0"
  linter
end
