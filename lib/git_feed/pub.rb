require 'rubygems'
require 'redis'
require 'json'
require 'yaml'
require 'git'

CONFIG = YAML.load_file("config.yml") unless defined? CONFIG
git = Git.open ('../..')

git.log.each_with_index do |commit, idx|
  if idx == 0 then
    $redis = Redis.new(:host => "#{CONFIG['host']}", :port => "#{CONFIG['port']}")
    data = {"user" => git.gcommit(commit).author.name, "msg" => git.gcommit(commit).message}
    $redis.publish 'git', data.to_json
    break
  end 
end
