#!/bin/sh

./stop.sh
echo $PWD
cd book-ticket-component
bundle exec evt-pg-recreate-db
cd ..
./start.sh
