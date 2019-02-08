./kill.sh

cd search-fare-component/
bundle exec evt-pg-recreate-db
cd ../

./start.sh
