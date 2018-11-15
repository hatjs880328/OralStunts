source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/aliyun/aliyun-specs.git'
platform :ios, '9.0'
#use_frameworks!
use_modular_headers!
inhibit_all_warnings!
#第三方库导入需要谨慎---防止单元测试框架编译失败---
#oc需添加:modular_headers => false指令
def useFrameworks
    
    pod 'Aspects', :modular_headers => false
    
    pod 'SnapKit', '~> 4.0.0'
    
    pod 'RxSwift', '~> 4.1.2'
    
    pod 'RxCocoa', '~> 4.1.2'
    
    pod 'RxDataSources', '~> 3.0.2'
    
    pod 'MJExtension', :modular_headers => false
    
    pod 'Bugly',:modular_headers => false
    
    pod 'BeeHive',:modular_headers => false
    
    pod 'SDWebImage',:modular_headers => false
    
    pod 'EvernoteSDK',:modular_headers => false
    
    pod 'SVGKit', :git => 'https://github.com/SVGKit/SVGKit.git', :branch => '2.x', :modular_headers => false
    
    pod 'WHDebugTool',:modular_headers => false
    
    pod 'MONActivityIndicatorView',:modular_headers => false
    
    pod 'FlatUIKit',:modular_headers => false
    
    pod 'AlicloudFeedback',:modular_headers => false
    
    pod 'SCLAlertView',:modular_headers => false
    
    pod 'FFToast',:modular_headers => false
    pod 'mob_sharesdk',:modular_headers => false
    pod 'mob_sharesdk/ShareSDKUI',:modular_headers => false
    pod 'mob_sharesdk/ShareSDKPlatforms/QQ',:modular_headers => false
    pod 'mob_sharesdk/ShareSDKPlatforms/SinaWeibo',:modular_headers => false
    pod 'mob_sharesdk/ShareSDKPlatforms/WeChat',:modular_headers => false
    pod 'mob_sharesdk/ShareSDKPlatforms/SMS',:modular_headers => false
    pod 'mob_sharesdk/ShareSDKConfigFile',:modular_headers => false
    pod 'mob_sharesdk/ShareSDKExtension',:modular_headers => false
    
    #pod 'AxcAE_TabBar'
    pod 'XRWaterfallLayout',:modular_headers => false
    
    pod 'HandyJSON', '~> 4.2.0'

    pod 'AliyunOSSiOS',:modular_headers => false
    
end

target 'OralStunts' do
    useFrameworks
end

target 'OralStuntsTests' do
    useFrameworks
end
