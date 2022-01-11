Pod::Spec.new do |spec|

    spec.name         = "WhiteTownUI"
    spec.version      = "0.1.3"
    spec.summary      = "WhiteTownUI framework"

    spec.homepage     = "https://github.com/whitetown/WhiteTownUI"
    spec.license      = { :type => "MIT", :file => "LICENSE" }
    spec.author       = { "WhiteTown" => "support@whitetown.com" }

    spec.ios.deployment_target = "12.1"
    spec.swift_version = "5.1"

    spec.source        = { :git => "https://github.com/whitetown/WhiteTownUI.git", :tag => "#{spec.version}" }
    spec.source_files  = "Sources/WhiteTownUI/**/*.swift"

    spec.dependency     'SnapKit'
    spec.dependency     'SwiftMessages'
    # spec.dependency     'NotificationBannerSwift'

end
