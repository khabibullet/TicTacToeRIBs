# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

target 'TicTacToe' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

  # Pods for TicTacToe
  pod "RIBs"
pod 'SnapKit', '~> 4.0.0'

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
               end
          end
   end
end

end