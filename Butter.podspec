Pod::Spec.new do |spec|
  spec.name         = 'Butter'
  spec.version      = '1.0.7'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/erd-s/Butter'
  spec.authors      = { 'Chris Erdos' => 'chris.erdos@gmail.com' }
  spec.summary      = 'A lightweight networking library.'
  spec.source       = { :git => 'https://github.com/erd-s/Butter.git', :tag => spec.version }
  spec.source_files = 'Sources/Butter/*.swift'
  spec.ios.deployment_target  = '13.4'
  spec.swift_version = '5.0'
end
