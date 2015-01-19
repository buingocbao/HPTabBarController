Pod::Spec.new do |s|

  s.name         = "HPTabBarController"
  s.version      = "1.2.0"
  s.summary      = "HPTabBarController is new style of cocoa controller"
  s.homepage     = "http://facebook.com/huyphams"
  s.license      = "MIT"
  s.author             = { "Huy Pham" => "duchuykun@gmail.com" }
  s.social_media_url   = "https://facebook.com/huyphams"
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/huyphams/HPTabBarController.git", :tag => "#{s.version}" }
  s.source_files  = "Class/*.{h,m}"
  s.requires_arc = true

end
