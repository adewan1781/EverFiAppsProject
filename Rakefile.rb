require 'rake/rspec'

#rspec_opts = "--tag login"
RSpec::Core::RakeTask.new(:login) do |t|
  t.rspec_opts = "--tag login --format html --out results.html"
end

RSpec::Core::RakeTask.new(:hometabs) do |t|
  t.rspec_opts = "--tag hometabs --format html --out results.html"
end

RSpec::Core::RakeTask.new(:reportscontent) do |t|
  t.rspec_opts = "--tag reportscontent --format html --out results.html"
end

RSpec::Core::RakeTask.new(:trlist) do |t|
  t.rspec_opts = "--tag trlist --format html --out results.html"
end

RSpec::Core::RakeTask.new(:verifytabs) do |t|
  t.rspec_opts = "--tag verifytabs --format html --out results.html"
end

RSpec::Core::RakeTask.new(:volunteersHome) do |t|
  t.rspec_opts = "--tag volunteersHome --format html --out results.html"
end

RSpec::Core::RakeTask.new(:assessments) do |t|
  t.rspec_opts = "--tag assessments --format html --out results.html"
end

RSpec::Core::RakeTask.new(:volunteertab) do |t|
  t.rspec_opts = "--tag volunteertab --format html --out results.html"
end

RSpec::Core::RakeTask.new(:organizationtab) do |t|
  t.rspec_opts = "--tag organizationtab --format html --out results.html"
end

RSpec::Core::RakeTask.new(:allspecs) do |t|
  t.rspec_opts = "--format html --out results.html"
end
task :default  => :organizationtab
#task :spec