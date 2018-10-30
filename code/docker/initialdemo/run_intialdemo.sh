#/bin/bash

docker run -d -v $(pwd)/mongo-data/db:/data/db -v $(pwd)/mongo-data/configdb:/data/configdb -v $(pwd)/json:/home/json -v $(pwd)/scripts:/home/scripts -w /home --name mongo01 mongo:xenial
