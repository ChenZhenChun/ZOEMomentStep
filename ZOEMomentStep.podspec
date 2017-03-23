Pod::Spec.new do |s|
#name必须与文件名一致
s.name              = "ZOEMomentStep"

#更新代码必须修改版本号
s.version           = "1.0.1"
s.summary           = "Steps for the iphone device."
s.description       = <<-DESC
It is a ZOEMomentStep used on iOS, which implement by Objective-C.
DESC
s.homepage          = "https://github.com/ChenZhenChun/ZOEMomentStep"
s.license           = 'MIT'
s.author            = { "ChenZhenChun" => "346891964@qq.com" }

#submodules 是否支持子模块
s.source            = { :git => "https://github.com/ChenZhenChun/ZOEMomentStep.git", :tag => s.version, :submodules => true}
s.platform          = :ios, '8.0'
s.requires_arc = true

#source_files路径是相对podspec文件的路径

#核心模块
s.subspec 'ZOEMomentStep' do |ss|
ss.source_files = 'ZOEMomentStep/ZOEMomentStep/*.{h,m}'
ss.public_header_files = 'ZOEMomentStep/ZOEMomentStep/*.h'
end

s.frameworks = 'Foundation', 'UIKit','CoreMotion'

# s.ios.exclude_files = 'Classes/osx'
# s.osx.exclude_files = 'Classes/ios'
# s.public_header_files = 'Classes/**/*.h'

end
