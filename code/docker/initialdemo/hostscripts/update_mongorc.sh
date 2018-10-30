#/bin/bash

docker cp ~/source/docker/mongo/initialdemo/scripts/common.js initialdemo_mongo_1:/root/.mongorc.js
docker exec initialdemo_mongo_1 chown root /root/.mongorc.js
docker exec initialdemo_mongo_1 chgrp root /root/.mongorc.js
