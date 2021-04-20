Pod::Spec.new do |s|

s.name         = "DPAppDoctor"
s.version      = "3.0.9"
s.ios.deployment_target = '8.0'
s.summary      = "A delightful setting interface framework."
s.homepage     = "https://github.com/xiayuqingfeng/DPAppDoctor"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author       = { "涂鸦" => "13673677305@163.com" }
s.source       = { :git => "https://github.com/xiayuqingfeng/DPAppDoctor.git", :tag => s.version }
s.source_files = "DPAppDoctor_SDK/**/*.{h,m}"
s.requires_arc = true
s.frameworks   = 'UIKit',"Foundation"
s.dependency   "FBRetainCycleDetector"
end
