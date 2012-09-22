# GitFeed

Git feed application. Feeds commit data from post-commit hook in git to a remote Redis server

## Installation

First download git repo

Run the following Rake command inside the downloaded repo
    
    rake install
    
Install the following gems

    gem install redis git json yaml 

Create a config.yml file under the .git/hooks directory of your git repository. The host parameter will point to your Redis instance
The port will be your Redis port. The config.yml file will look as follows:
    
    :host 127.0.0.1 
    :port 6379

Create a 2 line ruby script named post-commit in the .git/hooks repository of your git repository. It will look as follows:
    
    #!/usr/bin/env ruby
    require 'git_feed'
    
    GitFeed::GitFeed.new(feed='git',path='../../')

## Usage

Git feed application. Feeds commit data from post-commit hook in git to a remote Redis server

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
