Gem::Specification.new do |s|
  s.name        = "polar"
  s.version     = "0.2.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Grzegorz Kazulak", "Lukasz Tackowiak"]
  s.email       = ["grzegorz.kazulak@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/polar"
  s.description = %q{Control access like a bear}

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "polar"

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rspec-core", ">= 2.0.1"

  s.files        = `git ls-files`.split("\n")
  s.require_path = 'lib'
end