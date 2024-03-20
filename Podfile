# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Coffeee' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Coffeee

  pod 'lottie-ios'
  pod 'SnapKit'
  pod 'PTCardTabBar'
  pod 'OnboardKit'
  pod 'FirebaseAuth'
  pod 'FirebaseFirestore'
  pod 'FirebaseDatabase'
  pod "FlagPhoneNumber"
  pod 'DPOTPView'
  pod 'SDWebImage'
  pod 'TabsPager'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'SimpleQRCode'
  pod 'StatusAlert'
  pod 'CircleProgressView'
  pod "MBCircularProgressBar"
  
  # Set the minimum iOS version to 13.0

  platform :ios, '13.0'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
