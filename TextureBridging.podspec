Pod::Spec.new do |s|

    s.name         = "TextureBridging"
    s.version      = "1.0.0"
    s.summary      = "Allows bringing ASDisplayNode into the world of AutoLayout."
  
    s.description  = <<-DESC
    This library is a micro framework. Actuary, has just one source file.
    NodeView allows to bring ASDisplayNode into the world of AutoLayout.
                     DESC
  
    s.homepage     = "https://github.com/muukii/TextureBridging"
    s.license      = "MIT"
    s.author             = { "Muukii" => "muukii.app@gmail.com" }
    s.social_media_url   = "http://twitter.com/muukii_app"
    s.ios.deployment_target = "10.0"
    s.source       = { :git => "https://github.com/muukii/TextureBridging.git", :tag => "#{s.version}" }
    s.source_files  = "TextureBridging/**/*.swift"
  
    s.frameworks  = "UIKit", "AsyncDisplayKit"
    s.requires_arc = true
    s.dependency "Texture/Core", "~> 2.8.1"
  
  end
  