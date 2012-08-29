require 'rake'


task :default => 'test'

desc 'run all tests'
task :test do
  build_number = ENV.fetch('build_number', '0')
  success = system "./Scripts/jenkinsBuild.sh #{build_number}"

  output = success ? '### TESTS PASSED ###' : '### TESTS FAILED ###'
  puts output

  exit success
end
