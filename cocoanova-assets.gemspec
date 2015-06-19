Gem::Specification.new do |s|
    s.name        = 'cocoanova-assets'
    s.version     = '1.0.0'
    s.date        = '2015-06-20'
    s.summary     = "xcassets support for cocoanova"
    s.description = "xcassets support for cocoanova"
    s.authors     = ["Yanke Guo"]
    s.email       = 'me@yanke.io'
    s.files       = Dir['lib/**/*.rb']
    s.require_paths = ["lib"]
    s.homepage    =
        'http://rubygems.org/gems/cocoanova-assets'
    s.license       = 'MIT'

    s.add_runtime_dependency 'cocoanova', '~> 1.0.0'
    s.add_runtime_dependency 'nokogiri', '~> 1.6.0'
    s.add_runtime_dependency 'rmagick', '~> 2.15.0'
end
