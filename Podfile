use_frameworks!

workspace "QuickTableViewController"
project "QuickTableViewController"

def testing_frameworks
  pod "Nimble", git: "https://github.com/Quick/Nimble.git", tag: "v8.0.1", inhibit_warnings: true
  pod "Quick", git: "https://github.com/Quick/Quick.git", tag: "v2.0.0", inhibit_warnings: true
end

target "QuickTableViewController-iOSTests" do
  platform :ios, "8.0"
  testing_frameworks
end

target "QuickTableViewController-tvOSTests" do
  platform :tvos, "9.0"
  testing_frameworks
end

target "Example-iOS" do
  platform :ios, "8.0"
  pod "SwiftLint", podspec: "https://raw.githubusercontent.com/CocoaPods/Specs/e3dd78c1879b219e3cb65096c75c5cb3f4db2a64/Specs/4/0/1/SwiftLint/0.32.0/SwiftLint.podspec.json"
end

target "Example-tvOS" do
  platform :tvos, "9.0"
  pod "SwiftLint", podspec: "https://raw.githubusercontent.com/CocoaPods/Specs/e3dd78c1879b219e3cb65096c75c5cb3f4db2a64/Specs/4/0/1/SwiftLint/0.32.0/SwiftLint.podspec.json"
end
