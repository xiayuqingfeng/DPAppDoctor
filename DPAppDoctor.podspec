Pod::Spec.new do |s|

s.name         = "DPWidgetSum"
s.version      = "1.3.1"
s.ios.deployment_target = '7.0'
s.summary      = "A delightful setting interface framework."
s.homepage     = "https://github.com/xiayuqingfeng/DPWidgetSum"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author       = { "涂鸦" => "13673677305@163.com" }
s.source       = { :git => "https://github.com/xiayuqingfeng/DPWidgetSum.git", :tag => s.version }
s.source_files  = "DPWidgetSum_SDK/**/*.{h,m}"
s.requires_arc = true
end
