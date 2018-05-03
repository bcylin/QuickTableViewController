use_frameworks!

workspace "QuickTableViewController"
project "QuickTableViewController"

target "QuickTableViewController-iOSTests" do
  platform :ios, "8.0"
  pod "Nimble", git: "https://github.com/Quick/Nimble.git", tag: "v7.1.1"
  pod "Quick", git: "https://github.com/Quick/Quick.git", tag: "v1.3.0"
end

target "QuickTableViewController-tvOSTests" do
  platform :tvos, "9.0"
  pod "Nimble", git: "https://github.com/Quick/Nimble.git", tag: "v7.1.1"
  pod "Quick", git: "https://github.com/Quick/Quick.git", tag: "v1.3.0"
end

target "Example-iOS" do
  platform :ios, "8.0"
  pod "SwiftLint", podspec: "https://raw.githubusercontent.com/CocoaPods/Specs/master/Specs/4/0/1/SwiftLint/0.25.0/SwiftLint.podspec.json"
  pod "Weakify", git: "https://github.com/klundberg/Weakify.git", tag: "v0.4.0"
end
