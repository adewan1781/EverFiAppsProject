require 'rake/rspec'
#rspec_opts = "--tag login"
RSpec::Core::RakeTask.new(:final) do |t|
    t.rspec_opts = "--tag login --format html --out results.html"
  end
  
task :default  => :final
#task :spec