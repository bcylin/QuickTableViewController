install! "cocoapods", generate_multiple_pod_projects: true
inhibit_all_warnings!
use_frameworks!

workspace "QuickTableViewController"
project "QuickTableViewController"

def testing_frameworks
  pod "Nimble", git: "https://github.com/Quick/Nimble.git", tag: "v8.0.4"
  pod "Quick", git: "https://github.com/Quick/Quick.git", tag: "v2.2.0"
end

def linter
  pod "SwiftLint", podspec: "https://raw.githubusercontent.com/CocoaPods/Specs/master/Specs/4/0/1/SwiftLint/0.32.0/SwiftLint.podspec.json"
end

target "QuickTableViewController-iOSTests" do
  platform :ios, "8.0"
  testing_frameworks
  linter
end

target "QuickTableViewController-tvOSTests" do
  platform :tvos, "9.0"
  testing_frameworks
end
