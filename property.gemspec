Gem::Specification.new do |s|
  s.name              = "property"
  s.version           = "0.0.1"
  s.summary           = "Property Based Testing library"
  s.author            = ["Sergio Gil", "Mari Carmen Gutiérrez"]
  s.email             = "sgilperez@gmail.com"
  s.homepage          = "http://github.com/porras/property"
  
  s.extra_rdoc_files  = %w(README.md)
  s.rdoc_options      = %w(--main README.md)
  
  s.files             = %w(README.md) + Dir.glob("{lib/**/*}")
  s.require_paths     = ["lib"]
end