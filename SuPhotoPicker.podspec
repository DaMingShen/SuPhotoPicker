Pod::Spec.new do |s|  
  s.name             = "SuPhotoPicker"  
  s.version          = "1.0.0"  
  s.summary          = “一款具有预览功能的照片选择器”  
  s.description      = <<-DESC  
                       这是一款具有预览功能的照片选择器，Objective-C版本。  
                       DESC  
  s.homepage         = "https://github.com/DaMingShen/SuPhotoPicker"  
  s.license          = 'MIT'  
  s.author           = { “DaMingShen” => “446135517@qq.com" }  
  s.source           = { :git => "https://github.com/DaMingShen/SuPhotoPicker.git", :tag => “1.0.0” }  
  
  s.platform     = :ios, ‘8.0’  
  s.ios.deployment_target = ‘8.0’  
  s.osx.deployment_target = '10.7’  
  s.requires_arc = true  
  
  s.source_files = 'SuPhotoPickerDemo/**/*’   
  
end 