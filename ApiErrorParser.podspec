Pod::Spec.new do |spec|

  spec.name         = "ApiErrorParser"
  spec.version      = "0.0.3"
  spec.summary      = "Library for handling errors in the application based on codes"
  spec.homepage     = "https://github.com/velmie/ios-api-error-parser"
  spec.license      = "MIT"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.authors      = { "dmitrijmihajluk" => "mikhajlyuk@gmail.com" }
  spec.platform     = :ios, "11.0"
  spec.source       = { :git => "https://github.com/velmie/ios-api-error-parser.git", :tag => "#{spec.version}" }
  spec.source_files  = "Classes", "ApiErrorParser/**/*.{h,m,swift}"
  spec.public_header_files = "ApiErrorParser/**/*.h"
  spec.dependency 'ObjectMapper', '3.5.0'
  spec.swift_version = '5.0'

end
