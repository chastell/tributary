require 'rspec/core/rake_task'
ENV['TZ'] = 'Europe/Warsaw'
RSpec::Core::RakeTask.new :spec

desc 'Run Tributary console'
task :console do
  require 'irb'
  require_relative 'lib/tributary'
  include Tributary
  ARGV.clear
  IRB.start
end

task default: :spec
