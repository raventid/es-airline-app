# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'sms_component'
  s.version = '0.0.0'
  s.summary = ' '
  s.description = ' '

  s.authors = ['email@domain.com']
  s.homepage = 'http://domain.com'
  s.licenses = ['TODO']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.4'

  s.add_runtime_dependency 'eventide-postgres'

  s.add_development_dependency 'test_bench'
end
