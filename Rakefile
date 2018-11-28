require "rubygems"
require "stringex"
require "safe_yaml/load"

require_relative '_rakelibs/utils.rb'

$debug1 = true
$debug2 = true

# number of time site is build when doing a rake bench
# this allows to get an average
$benchmarkCycles = 1

$rootPath = __dir__
d1("Current directory : #{$rootPath}")

$configPath = File.join($rootPath, '_config.yml')
$config     = SafeYAML::load_file($configPath)
$posts_dir  = "_posts"

task :default => [:meta]

desc "launch metadatas edition"
task :meta do
    d2(">> metadatas edition")

end
