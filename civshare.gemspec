Gem::Specification.new do |s|
  s.name = 'civshare'
  s.version = '0.0.1'
  s.date = '2013-01-15'

  s.summary = 'API client for creating gift cards from CivChoice'
  s.description = 'API client for creating gift cards from CivChoice'

  s.authors = ['Todd Willey (xtoddx)']
  s.email = 'xtoddx@gmail.com'
  s.homepage = 'http://github.com/CirrusMio/civshare'

  s.require_paths = %w[lib]

  s.rdoc_options = ["--charset=UTF-8"]
  s.extra_rdoc_files = %w[README.md]

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {spec,tests}/*`.split("\n")
end
