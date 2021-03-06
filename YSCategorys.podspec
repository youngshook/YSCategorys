Pod::Spec.new do |s|

  s.name         = "YSCategorys"
  s.version      = "1.2.0"
  s.summary      = "A set of categorys to make iOS development easier."
  s.homepage     = "http://github.com/youngshook/YSCategorys"
  s.license      = "MIT"
  s.author       = { "Young Shook" => "shook.young@gmail.com" }
  s.social_media_url   = "http://weibo.com/justfuckingdoit"
  s.ios.deployment_target = "8.0"
  s.public_header_files = 'Categorys/**/*.h'
  s.source       = { :git => "https://github.com/youngshook/YSCategorys.git", :tag => s.version.to_s }
  s.source_files = 'Categorys/**/*.h'
  s.requires_arc = true

  s.subspec 'UIKit' do |ss|
  ss.public_header_files = 'Categorys/UIKit/*.h'
  ss.source_files = 'Categorys/UIKit'
  ss.ios.framework = 'UIKit','QuartzCore'
  end

  s.subspec 'Foundation' do |ss|
  ss.public_header_files = 'Categorys/Foundation/*.h'
  ss.source_files = 'Categorys/Foundation'
  ss.ios.framework = 'Foundation'
  end

end



