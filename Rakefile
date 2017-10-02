require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs = []
  t.warning = true
  t.test_files = FileList['./specs/*_spec.rb']
end

task default: :test
