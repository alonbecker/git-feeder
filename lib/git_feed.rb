#require_relative "git_feed/version"
require 'rubygems'
require 'redis'
require 'json'
require 'yaml'
require 'git'


module GitFeed

  class GitFeed 
    #Config file must be placed in the .git/hooks/directory
    CONFIG = YAML.load_file('config.yml') unless defined? CONFIG 

    def initialize(feed = 'git', path = '../')
      git = Git.open (path)

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
 
      data = 
      {
        "user" 	=> commit.author.name, 
        "email"	=> commit.author.email,
        "date" 	=> commit.date.strftime("%Y-%m-%d %H:%M:%S %z"),
        "msg" 	=> commit.message,
        "branch"=> commit.name,
        "files"	=> files
      }

      $redis = Redis.new(:host => "#{CONFIG['host']}", :port => "#{CONFIG['port']}")
      $redis.publish feed, data.to_json
    end
  end
end
