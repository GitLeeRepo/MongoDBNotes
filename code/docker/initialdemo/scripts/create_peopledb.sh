#/bin/bash

mongoimport --db people --collection user_lead  --file /home/json/user.json
mongoimport --db people --collection user_list --jsonArray --file /home/json/users.json

