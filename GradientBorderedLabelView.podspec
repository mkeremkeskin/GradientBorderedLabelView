#
# Be sure to run `pod lib lint GradientBorderedLabelView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GradientBorderedLabelView'
  s.version          = '0.1.1'
  s.summary          = 'IBDesignable label with customizable gradient attributes'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Custom IBDesignable label which which you can create catchy gradient labels from code or storyboard.
                       DESC

  s.homepage         = 'https://github.com/mkeremkeskin/GradientBorderedLabelView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mkeremkeskin' => 'mkeremkeskin@gmail.com' }
  s.source           = { :git => 'https://github.com/mkeremkeskin/GradientBorderedLabelView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/mkeremkeskin'

  s.ios.deployment_target = '9.0'
  s.swift_version = '4.0'

  s.source_files = 'GradientBorderedLabelView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'GradientBorderedLabelView' => ['GradientBorderedLabelView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
