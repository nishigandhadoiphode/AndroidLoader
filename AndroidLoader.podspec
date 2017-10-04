#
# Be sure to run `pod lib lint AndroidLoader.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AndroidLoader'
  s.version          = '0.1.0'
  s.summary          = 'AndroidLoader provides a ready to use loader on ViewController whose look and feel is like android default loader.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Create object of  AndroidLoaderView class and call show and hide methods to opeerate the loader which is like android loader.
                       DESC

  s.homepage         = 'https://github.com/nishigandhadoiphode/AndroidLoader'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'nishigandhadoiphode' => 'nsdoiphode@gmail.com' }
  s.source           = { :git => 'https://github.com/nishigandhadoiphode/AndroidLoader.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/nishidoiphode'

  s.ios.deployment_target = '8.0'

  s.source_files = 'AndroidLoader/Classes/**/*'
  
  # s.resource_bundles = {
  #   'AndroidLoader' => ['AndroidLoader/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
