require 'rubygems'
require 'redis'
require 'json'
require 'yaml'
require 'git'

CONFIG = YAML.load_file("config.yml") unless defined? CONFIG
git = Git.open ('../..')

commits = git.log(2)
commit = ''
last_commit = ''

commits.each_with_index do |sha1, idx|
  commit = git.gcommit(sha1) if idx == 0
  last_commit = git.gcommit(sha1) if idx == 1
end

files = Array.new

git.diff(commit, last_commit).each do |file|
   files.push(file.path)
end

puts git.gcommit(git.log(1)).name
 
data = 
  {
    "user" 	=> commit.author.name, 
    "email" 	=> commit.author.email,
    "date" 	=> commit.date.strftime("%Y-%m-%d %H:%M:%S %z"),
    "msg" 	=> commit.message,
    "branch" 	=> commit.name,
    "files" 	=> files
  }

$redis = Redis.new(:host => "#{CONFIG['host']}", :port => "#{CONFIG['port']}")
$redis.publish 'git', data.to_json
