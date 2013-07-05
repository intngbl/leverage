namespace :travis do
  desc "Run Rspec and Cucumber tests on Travis CI"
  task :test => :environment do
    # Reference http://about.travis-ci.org/docs/user/gui-and-headless-browsers
    ["rspec spec", "rake cucumber"].each do |cmd|
      puts "Starting to run #{cmd}..."
      system("export DISPLAY=:99.0 && bundle exec #{cmd}")
      raise "#{cmd} failed!" unless $?.exitstatus == 0
    end
  end

  desc "Load figaro environment variables into .travis.yml"
  task :figaro => :environment do
    Figaro.env(ENV['RAILS_ENV']).each do |k,v|
      system "travis encrypt '#{k}=#{v}' --add env"
    end
  end

end
