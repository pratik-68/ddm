# README

* Ruby version 

2.6.5

* System dependencies 

Redis

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Job queues 

**Sidekiq**
https://gist.github.com/wbotelhos/fb865fba2b4f3518c8e533c7487d5354

**Run this command to run job server**
bundle exec sidekiq -q default -q mailers

require 'sidekiq/api'

1. Clear retry set
Sidekiq::RetrySet.new.clear

1. Clear scheduled jobs 
Sidekiq::ScheduledSet.new.clear

* Deployment instructions
