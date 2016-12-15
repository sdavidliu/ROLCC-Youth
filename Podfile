# Uncomment the next line to define a global platform for your project
# platform :ios, ‘9.0’

target 'ROLCC Youth' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ROLCC Youth
  pod 'RAMAnimatedTabBarController', "~> 2.0.13"
  pod 'Firebase'
  pod 'Firebase/Database'
  pod 'Firebase/Storage'
  pod 'SnapKit'
  pod 'Auk', '~> 7.0'
  pod ‘BouncyPageViewController’
  pod 'GuillotineMenu', '~> 3.0'

  target 'ROLCC YouthTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ROLCC YouthUITests' do
    inherit! :search_paths
    # Pods for testing
  end

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '3.0'
      end
    end
  end

end
