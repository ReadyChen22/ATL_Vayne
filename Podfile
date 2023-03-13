source 'https://github.com/CocoaPods/Specs.git'

platform :ios, 13.0
use_frameworks!

def pods
    pod 'SDWebImage', '~> 5.0'
    pod 'SwiftyJSON'
    pod 'SwifterSwift'
    pod 'IQKeyboardManagerSwift', '~> 6.5.10'
end

target 'atl_vayne_ready' do
    pods
end


post_install do |installer|
  
  # ref https://stackoverflow.com/a/69959316
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
  
  # ref https://stackoverflow.com/a/72600584
  # Xcode 14 起，pod 裡的 某某 libs 會觸發，要指定 Teams
  installer.generated_projects.each do |project|
    project.targets.each do |target|
        target.build_configurations.each do |config|
            # config.build_settings["DEVELOPMENT_TEAM"] = "Your Team ID" <- 如果你要指定 Teams
            config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'  # <- 全部不指定 Teams
         end
    end
  end

end
