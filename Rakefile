require 'rake/testtask'

Rake::TestTask.new('test') do |t|
  t.libs += ['test', 'properties']
  t.test_files = FileList['{test,properties}/**/*_test.rb']
  t.verbose = true
end

Rake::TestTask.new('properties') do |t|
  t.libs << 'properties'
  t.test_files = FileList['properties/**/*_properties.rb']
  t.verbose = true
end

task :default => [:test, :properties]