platform :ios, "8.0"
use_frameworks!

workspace "QuickTableViewController"

target "QuickTableViewControllerTests-iOS" do
  project "QuickTableViewController"
  pod "Nimble", git: "https://github.com/Quick/Nimble.git", tag: "v5.0.0"
  pod "Quick", git: "https://github.com/Quick/Quick.git", tag: "v0.10.0"
end

target :Example do
  project "Example"
  pod "QuickTableViewController", path: "./"
end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["SWIFT_VERSION"] = "3.0"
    end
  end
end
