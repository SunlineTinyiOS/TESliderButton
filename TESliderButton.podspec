#
# Be sure to run `pod lib lint TESliderButton.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TESliderButton'
  s.version          = '0.1.1'
  s.summary          = '滑块组件，cimb 需要'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'cimb 需要滑块组件支持，大佬，无解'

  s.homepage         = 'https://github.com/SunlineTinyiOS/TESliderButton'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '顾卫明' => '471289774@qq.com' }
  s.source           = { :git => 'https://github.com/SunlineTinyiOS/TESliderButton.git'}
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'TESliderButton/Classes/**/*'
  
  # s.resource_bundles = {
  #   'TESliderButton' => ['TESliderButton/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
