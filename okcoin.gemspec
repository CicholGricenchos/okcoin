Gem::Specification.new do |spec|
  spec.name          = 'okcoin'
  spec.version       = '0.0.1'
  spec.authors       = ['cichol']
  spec.email         = ['cichol@live.cn']

  spec.summary       = ''
  spec.description   = ''

  spec.files         = Dir.glob("lib/**/*.rb")

  spec.add_dependency 'websocket'
  spec.add_dependency 'celluloid/io'
end