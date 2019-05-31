Pod::Spec.new do |s|
  s.name = 'SwitchKit'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'A Swift Framework for iOS & OS X that let you change the behavior and appearance of your app without requiring users to download an app update.'
  s.homepage = 'https://github.com/switchkit/switchkit-cocoa'
  s.source = { :git => 'https://github.com/switchkit/switchkit-cocoa.git', :tag => '1.0.0' }

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'

  s.source_files = 'Source/*.swift'

  s.swift_version = '5.0'
end
