#/bin/bash

# run script to drop database
mongo < /home/scripts/drop_peopledb.mshell

# recreate database and fill collections from JSON import
mongoimport --db people --collection user_lead  --file /home/json/user.json
mongoimport --db people --collection user_list --jsonArray --file /home/json/users.json

