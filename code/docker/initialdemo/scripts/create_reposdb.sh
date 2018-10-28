#/bin/bash

# run script to drop database
mongo < /home/scripts/drop_reposdb.mshell

# recreate database and fill collections from JSON import
mongoimport --db repos --collection github_user --file /home/json/gituserinfo.json
mongoimport --db repos --collection github_repos --jsonArray --file /home/json/repos.json

