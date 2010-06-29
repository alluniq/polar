require 'rubygems'
require 'rake'

begin
  gem 'jeweler', '~> 1.4'
  require 'jeweler'

  Jeweler::Tasks.new do |gem|
    gem.name        = 'grizzly'
    gem.summary     = 'ACL for Rails 3'
    gem.description = 'Control access like a Bear'
    gem.email       = 'grzegorz.kazulak@gmail.com'
    gem.homepage    = 'http://github.com/grzegorzkazulak/grizzly/%s' % gem.name
    gem.authors     = [ 'Grzegorz Kazulak']

    gem.rubyforge_project = 'grizzly'
    gem.add_dependency 'railties',        '>= 3.0.0.beta4'
  end

  Jeweler::GemcutterTasks.new

  FileList['tasks/**/*.rake'].each { |task| import task }
rescue LoadError
  puts 'Jeweler (or a dependency) not available. Install it with: gem install jeweler'
end

task(:spec) {} # stub out the spec task for as long as we don't have any specs