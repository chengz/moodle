require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/services/test_*.rb', 'test/test_*.rb']
end

desc "Running tests"
task :default => :test
