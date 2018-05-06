require 'date'

Gem::Specification.new do |s|
  s.name              = "mrproper"
  s.version           = "0.0.4"
  s.date              = Date.today
  s.summary           = "Property Based Testing library"
  s.author            = ["Sergio Gil", "Mari Carmen Gutiérrez"]
  s.email             = "sgilperez@gmail.com"
  s.homepage          = "http://github.com/porras/mrproper"

  s.extra_rdoc_files  = %w(README.md)
  s.rdoc_options      = %w(--main README.md)

  s.files             = %w(README.md) + Dir.glob("{lib/**/*}")
  s.require_paths     = ["lib"]

  s.add_runtime_dependency 'minitest'
end
