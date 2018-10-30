#/bin/bash

# offer to exclude these files since they may be host dependent
read -p "Exclude *.yml and run*.shl files from copy (Y/n): " doit

if [ -z "$doit" ]
then
    doit="Y"
fi

doit=${doit^^} # toupper

echo $doit

# Offer to do a dry run to see what the results would be
read -p "Perform dry run (Y/n): " dodryrun

if [ -z "$dodryrun" ]
then
    dodryrun="Y"
fi

dodryrun=${dodryrun^^} # toupper

echo $dodryrun

# conditionally run the rsync with differing options

if [ $dodryrun == "Y" ] ||  [ $dodryrun == "YES" ]
then
    if [ $doit == "Y" ] ||  [ $doit == "YES" ]
    then
        rsync --dry-run --exclude=*.yml --exclude=run*.sh  -arvv ~/source/repos/MongoDBNotes/code/docker/initialdemo/  ~/source/docker/mongo/initialdemo/
    else
        rsync --dry-run --exclude=*.yml --exclude=run*.sh  -arvv ~/source/repos/MongoDBNotes/code/docker/initialdemo/  ~/source/docker/mongo/initialdemo/
    fi
else
    if [ $doit == "Y" ] ||  [ $doit == "YES" ]
    then
        rsync --exclude=*.yml --exclude=run*.sh  -arvv ~/source/repos/MongoDBNotes/code/docker/initialdemo/  ~/source/docker/mongo/initialdemo/
    else
        rsync --exclude=*.yml --exclude=run*.sh  -arvv ~/source/repos/MongoDBNotes/code/docker/initialdemo/  ~/source/docker/mongo/initialdemo/
    fi
fi

ls ~/source/docker/mongo/initialdemo/
