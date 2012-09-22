require 'rubygems'
require 'redis'
require 'json'
require 'yaml'

CONFIG = YAML.load_file("config.yml") unless defined? CONFIG


puts "hello #{CONFIG['host']}"

$redis = Redis.new(:host => "#{CONFIG['host']}", :port => "#{CONFIG['port']}")
#test2
data = {"user" => ARGV[1]}

loop do
    msg = STDIN.gets
    $redis.publish ARGV[0], data.merge('msg' => msg.strip).to_json
end
