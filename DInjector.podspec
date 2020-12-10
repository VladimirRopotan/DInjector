Pod::Spec.new do |s|

  s.name = 'DInjector'
  s.version = '0.1'
  s.license = 'MIT'
  s.summary = 'Library for Dependency Injection in Swift'
  s.homepage = 'https://github.com/VladimirRopotan/DInjector'
  s.authors = { 'Ropotan Vladimir' => 'pro100.kep@gmail.com' }
  s.source = { :git => 'https://github.com/VladimirRopotan/DInjector.git', :tag => s.version }
  s.documentation_url = 'https://github.com/VladimirRopotan/DInjector'

  s.ios.deployment_target = '10.0'

  s.swift_versions = "5"

  s.source_files = 'Source/**/*.swift'
end