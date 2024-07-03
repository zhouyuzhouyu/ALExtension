#
# Be sure to run `pod lib lint ALExtension.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ALExtension'
  s.version          = '0.2.0'
  s.summary          = 'A short description of ALExtension.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
ALExtension is a collection of some useful extensions for iOS development.
                       DESC

  s.homepage         = 'https://github.com/745611/ALExtension'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '745611' => '524112470@qq.com' }
  s.source           = { :git => 'https://github.com/745611/ALExtension.git', :tag => s.version.to_s }

  s.ios.deployment_target = '12.0'

  s.source_files = 'ALExtension/Classes/**/*.{h,m}'

  s.public_header_files = 'Pod/Classes/ALExtensionHeader.h'
  s.frameworks = 'UIKit', 'Foundation', 'AVFoundation', 'AssetsLibrary', 'QuartzCore'

end
