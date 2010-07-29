require 'rake'
require 'spec/rake/spectask'
adapters = Dir[File.dirname(__FILE__) + '/lib/polar/adapter/*.rb'].map{|file| File.basename(file, '.rb') }

task :spec do
  adapters.map{|adapter| "spec:#{adapter}"}.each do |spec|
    Rake::Task[spec].invoke
  end
end

namespace :spec do
  adapters.each do |adapter|
    Spec::Rake::SpecTask.new(adapter) do |spec|
      spec.spec_files = FileList['spec/*_spec.rb']
    end
  end
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

begin
  gem 'jeweler', '~> 1.4'
  require 'jeweler'

  Jeweler::Tasks.new do |gem|
    gem.name        = 'Polar'
    gem.summary     = 'Access control for polar bears'
    gem.description = 'Control access like a bear'
    gem.email       = 'grzegorz.kazulak@gmail.com'
    gem.homepage    = 'http://github.com/grzegorzkazulak/%s' % gem.name
    gem.authors     = [ 'Grzegorz Kazulak', 'Lukasz Tackowiak']

    gem.rubyforge_project = 'grizzlies'
  end

  Jeweler::GemcutterTasks.new

  FileList['tasks/**/*.rake'].each { |task| import task }
rescue LoadError
  puts 'Jeweler (or a dependency) not available. Install it with: gem install jeweler'
end

task(:spec) {} # stub out the spec task for as long as we don't have any specs