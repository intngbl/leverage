desc "Run Rspec and Cucumber tests on Travis CI"

# Reference http://about.travis-ci.org/docs/user/gui-and-headless-browsers
task :travis do
  ["rspec spec", "rake cucumber"].each do |cmd|
    puts "Starting to run #{cmd}..."
    system("export DISPLAY=:99.0 && bundle exec #{cmd}")
    raise "#{cmd} failed!" unless $?.exitstatus == 0
  end
end

