require 'rake'
require 'spec/rake/spectask'
adapters = Dir[File.dirname(__FILE__) + '/lib/grizzly/adapter/*.rb'].map{|file| File.basename(file, '.rb') }

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
    gem.name        = 'grizzly'
    gem.summary     = 'ACL for bears'
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