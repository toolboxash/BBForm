#
# Be sure to run `pod lib lint BBForm.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "BBForm"
  s.version          = "0.1.6"
  s.summary          = "A simple form solution for iOS with validation"
#  s.description      = <<-DESC
#                       An optional longer description of BBForm
#
#                       * Markdown format.
#                       * Don't worry about the indent, we strip it!
#                       DESC
  s.homepage         = "https://github.com/toolboxash/BBForm"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Ashley Thwaites" => "ash@toolbox-design.co.uk" }
  s.source           = { :git => "https://github.com/toolboxash/BBForm.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/{BBFormValidation,BBForm}/**/*.{h,m}'
#  s.resource_bundles = {
#    'BBForm' => ['Pod/Assets/*.png']
#  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'PureLayout'
end
