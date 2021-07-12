Pod::Spec.new do |spec|
  spec.name          = 'incetro-validator'
  spec.module_name   = 'Validator'
  spec.version       = '0.0.2'
  spec.license       = 'MIT'
  spec.authors       = { 'incetro' => 'incetro@ya.ru' }
  spec.homepage      = "https://github.com/Incetro/validator.git"
  spec.summary       = 'Open Source'
  spec.platform      = :ios, "12.0"
  spec.swift_version = '5.0'
  spec.source        = { git: "https://github.com/Incetro/validator.git", tag: "#{spec.version}" }
  spec.source_files  = "Sources/Validator/**/*.{h,swift}"
end