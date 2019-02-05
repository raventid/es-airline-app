#!/bin/sh

cd external_applications
ruby charters.rb &
ruby wolfgang.rb &
cd ../charters-component
ruby ./script/start &
cd ../wolfgang-component
ruby ./script/start &
cd ../search-fare-component
ruby ./script/start &
cd ../search-fare-view-component
ruby ./lib.rb &
cd ../web
rackup config.ru &
