#!/bin/sh

./kill.sh
echo $PWD
cd book-ticket-component
bundle exec evt-pg-recreate-db
cd ..
./start.sh
