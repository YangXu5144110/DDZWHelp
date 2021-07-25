 #
# Be sure to run `pod lib lint DinDoBaseKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DinDoBaseKit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of DinDoBaseKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/wg/DinDoBaseKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wg' => '492109923@qq.com' }
  s.source           = { :git => 'https://github.com/wg/DinDoBaseKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'DinDoBaseKit/Classes/**/*'
  s.prefix_header_file = 'DinDoBaseKit/Classes/DinDoBaseKit.h'

  # s.resource_bundles = {
  #   'DinDoBaseKit' => ['DinDoBaseKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking'
  s.dependency 'SVProgressHUD'
  s.dependency 'MBProgressHUD'
  s.dependency 'MJRefresh'
  s.dependency 'SDWebImage'
  s.dependency 'DateTools'
  s.dependency 'Masonry'
  s.dependency 'MJExtension'
  s.dependency 'IQKeyboardManager'
  s.dependency 'CYLTabBarController'
  s.dependency 'RTRootNavigationController'
  s.dependency 'DZNEmptyDataSet'
  s.dependency 'SDCycleScrollView'
  s.dependency 'HWPopController'
  s.dependency 'JXCategoryView'
  s.dependency 'WebViewJavascriptBridge'
  s.dependency 'TZImagePickerController'
  s.dependency 'YBImageBrowser/Video'

  s.dependency 'LBXScan/LBXNative'
  s.dependency 'LBXScan/UI'
  
  # 百度地图定位
  s.dependency 'BMKLocationKit'

  # 友盟推送
  s.dependency 'UMCCommon'
  s.dependency 'UMCPush'

  # 视频播放
  s.dependency 'SJVideoPlayer'
  s.dependency 'SJBaseVideoPlayer'
  
  # 数据存储
  s.dependency 'FMDB'

  # 图形化报表
  s.dependency 'AAChartKit'


end
