#!/bin/sh

cd external_applications

ruby charters.rb &
echo $! >>/tmp/es_airline_app_charter.pid

ruby wolfgang.rb &
echo $! >>/tmp/es_airline_app_wolfgang.pid

ruby cardo.rb &
echo $! >>/tmp/es_airline_app_cardo.pid

cd ../charters-component
ruby ./script/start &
echo $! >>/tmp/es_airline_app_charters_component.pid

cd ../wolfgang-component
ruby ./script/start &
echo $! >>/tmp/es_airline_app_wolfgang_component.pid

cd ../search-fare-component
ruby ./script/start &
echo $! >>/tmp/es_airline_app_search_fare_component.pid

cd ../book-ticket-component
ruby ./script/start &
echo $! >>/tmp/es_airline_app_book_ticket_component.pid

cd ../search-fare-view-component
ruby ./lib.rb &
echo $! >>/tmp/es_airline_app_search_fare_view_component.pid

cd ../web
rackup config.ru &
echo $! >>/tmp/es_airline_app_web.pid
