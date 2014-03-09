Pod::Spec.new do |s|
  s.name         = "CSConfigurationManager"
  s.version      = "0.0.1"
  s.summary      = "CSConfigurationManager helps managing 'per build target' configurations such as URLs from plist files."
  s.homepage     = "https://github.com/marcammann/CSConfigurationManager"

  s.license      = 'Apache 2'
  s.author       = { "Marc Ammann" => "marc@codesofa.com" }
  s.source       = { :git => "https://github.com/marcammann/CSConfigurationManager.git", :tag => "0.0.1" }
  s.platform     = :ios
  s.source_files = "Classes"
  s.requires_arc = true
end
