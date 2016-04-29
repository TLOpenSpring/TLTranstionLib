#
# Be sure to run `pod lib lint TLTranstionLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "TLTranstionLib"
  s.version          = "1.0.0"
  s.summary          = "史上最全的ViewController之间切换动画的类库，API简单易用"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
   "充分利用了ios7中新增的api,自定义ViewContrller转场动画特效，该类库不仅可以在Viewcontroller之间切换使用，在UINavigationController和UItabbarController中同样适用"

  s.homepage         = "https://github.com/TLOpenSpring/TLTranstionLib"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Andrew" => "anluanlu123@163.com" }
  s.source           = { :git => "https://github.com/TLOpenSpring/TLTranstionLib.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'TLTranstionLib/Classes/**/*'
  
  # s.resource_bundles = {
  #   'TLTranstionLib' => ['TLTranstionLib/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
