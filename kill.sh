#!/bin/sh

# Error -> No such process is fine.

kill -9 `cat /tmp/es_airline_app_charter.pid`
rm /tmp/es_airline_app_charter.pid
kill -9 `cat /tmp/es_airline_app_wolfgang.pid`
rm /tmp/es_airline_app_wolfgang.pid
kill -9 `cat /tmp/es_airline_app_cardo.pid`
rm /tmp/es_airline_app_cardo.pid
kill -9 `cat /tmp/es_airline_app_charters_component.pid`
rm /tmp/es_airline_app_charters_component.pid
kill -9 `cat /tmp/es_airline_app_wolfgang_component.pid`
rm /tmp/es_airline_app_wolfgang_component.pid
kill -9 `cat /tmp/es_airline_app_search_fare_component.pid`
rm /tmp/es_airline_app_search_fare_component.pid
kill -9 `cat /tmp/es_airline_app_book_ticket_component.pid`
rm /tmp/es_airline_app_book_ticket_component.pid
kill -9 `cat /tmp/es_airline_app_search_fare_view_component.pid`
rm /tmp/es_airline_app_search_fare_view_component.pid
kill -9 `cat /tmp/es_airline_app_web.pid`
rm /tmp/es_airline_app_web.pid
