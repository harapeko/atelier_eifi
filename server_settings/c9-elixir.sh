#!/usr/bin/env bash

############### USAGE ###############
# 
# 1. Create a new workspace on Cloud9 using the "Blank" template
#
# 2. Run this command in the console:
#    bash <(curl -fsSL https://gist.githubusercontent.com/padde/3c6301f15cbd5025e131740dae33aa95/raw/c9-elixir.sh)
#
# 3. There is no step 3!

# It seems we need to remove couchdb to prevent some problems during installation...
echo -----
echo REMOVING BROKEN COUCHDB
echo -----
sudo touch /etc/init.d/couchdb
sudo apt-get remove -y couchdb
sudo apt-get autoremove -y

echo
echo -----
echo ADDING ERLANG PACKAGE REPOSITORIES
echo -----
wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
sudo dpkg -i erlang-solutions_1.0_all.deb
rm erlang-solutions_1.0_all.deb
sudo apt-get update

echo
echo -----
echo INSTALLING ERLANG AND ELIXIR
echo -----
sudo apt-get install -y elixir erlang-base-hipe erlang-dev erlang-eunit erlang-parsetools

echo
echo -----
echo INSTALLING HEX PACKAGE MANAGER
echo -----
mix local.hex --force

echo
echo -----
echo UPDATING NODE.JS
echo -----
source ~/.nvm/nvm.sh
nvm install stable
nvm alias default stable

echo
echo -----
echo SETTING UP POSTGRES
echo -----
sudo service postgresql start
psql << EOF
    ALTER USER postgres WITH PASSWORD 'postgres';
    UPDATE pg_database SET datistemplate = FALSE WHERE datname = 'template1';
    DROP DATABASE template1;
    CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UNICODE';
    UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template1';
    \c template1
    VACUUM FREEZE;
    \q
EOF

echo
echo -----
echo INSTALLING PHOENIX DEPENDENCIES
echo -----
sudo apt-get install -y inotify-tools
mix local.rebar --force

echo
echo -----
echo INSTALLING PHOENIX
echo -----
mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force

echo
echo ALL DONE!
