require "bundler"
require "bundler/setup"

Bundler::GemHelper.install_tasks

require "rake/testtask"

Rake::TestTask.new(:spec) do |t|
  t.libs << "lib"
  t.libs << "test"
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
  t.ruby_opts = %w[-rubygems]
end

task :default => "spec"
