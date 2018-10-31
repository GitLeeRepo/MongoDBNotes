#/bin/bash

# Offer to do a dry run to see what the results would be
read -p "Perform dry run (y/N): " dodryrun

if [ -z "$dodryrun" ]
then
    dodryrun="N"
fi

dodryrun=${dodryrun^^} # toupper

echo $dodryrun

# conditionally run the rsync with differing options

if [ $dodryrun == "Y" ] ||  [ $dodryrun == "YES" ]
then
    rsync --dry-run --delete --exclude=mongo-data -arvv   ~/source/docker/mongo/initialdemo/ ~/source/repos/MongoDBNotes/code/docker/initialdemo/
else
    rsync --delete --exclude=mongo-data -arvv   ~/source/docker/mongo/initialdemo/ ~/source/repos/MongoDBNotes/code/docker/initialdemo/
fi

ls -R ~/source/repos/MongoDBNotes/code/docker/initialdemo
