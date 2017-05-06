target 'ReinClient' do
  use_frameworks!

  # Pods for ReinClient
  pod 'Alamofire'
  pod 'RealmSwift'
  pod 'SwiftyJSON'

  target 'ReinClientTests' do
    inherit! :search_paths
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0.2'
    end
  end
end
