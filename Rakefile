require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs = ["Lib"]
  t.warning = true
  t.test_files = FileList['Spec/*_spec.rb']
end

task default: :test
