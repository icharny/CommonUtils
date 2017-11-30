#
# Be sure to run `pod lib lint CommonUtils.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CommonUtils'
  s.version          = '0.1.0'
  s.summary          = 'Common utilities when developing iOS/Swift apps.'

  s.description      = <<-DESC
This is a collection of utilities and extensions that make developing iOS/Swift apps easier.
                       DESC

  s.homepage         = 'https://github.com/icharny/CommonUtils'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'icharny' => 'isaac.charny@gmail.com' }
  s.source           = { :git => 'https://github.com/icharny/CommonUtils.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'CommonUtils/**/*.swift'
  s.frameworks = 'UIKit'
end
