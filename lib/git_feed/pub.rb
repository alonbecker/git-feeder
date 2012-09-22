require 'rubygems'
require 'redis'
require 'json'
require 'yaml'
require 'git'

CONFIG = YAML.load_file("config.yml") unless defined? CONFIG
git = Git.open ('../..')

$redis = Redis.new(:host => "#{CONFIG['host']}", :port => "#{CONFIG['port']}")
data = 
  {
    "user" => git.gcommit(git.log(1)).author.name, 
    "msg" => git.gcommit(git.log(1)).message
  }
$redis.publish 'git', data.to_json
