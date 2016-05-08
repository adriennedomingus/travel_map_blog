#!/bin/bash
sudo apt-get install -y software-properties-common build-essential libpq-dev postgresql git nodejs imagemagick
sudo apt-add-repository ppa:brightbox/ruby-ng
sudo apt-get update
sudo apt-get install -y ruby2.2 ruby2.2-dev

gem install bundler

bundle install --gemfile=/vagrant/Gemfile
sudo -u postgres psql -1 -c "CREATE USER db_service WITH PASSWORD 'abc123';"
sudo -u postgres psql -1 -c "ALTER USER db_service WITH SUPERUSER;"
rake --rakefile=/vagrant/Rakefile db:create db:migrate
cd /vagrant
ip="$(ifconfig | grep -A 1 'eth0' | tail -1 | cut -d ':' -f 2 | cut -d ' ' -f 1)"
rails s -p 80 -d --binding=$ip
