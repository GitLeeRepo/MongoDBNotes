#/bin/bash

# run script to drop database
mongo < /home/scripts/drop_cspelldb.mshell

# recreate database and fill collections from JSON import
mongoimport --db cspell --collection cspell01 --file /home/json/cspell01.json
mongoimport --db cspell --collection cspell02 --file /home/json/cspell02.json

