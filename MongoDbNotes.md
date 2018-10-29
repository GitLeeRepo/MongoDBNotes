# Overview

Notes on the MongoDB database.

# References

* [Download Community Version](https://www.mongodb.com/download-center#community)

## Mongo Docs

* [docs.mongodb.com](https://docs.mongodb.com/) -- Documentation Page

## Mongo Scripts

* [mongo shell scripts](https://docs.mongodb.com/manual/tutorial/write-scripts-for-the-mongo-shell/)

## YouTube Videos

* [MongoDb in 30 minutes](https://www.youtube.com/watch?v=pWbMrx5rVBE) -- Brad Traversy

## My Other Notes

* [DockerNotes](https://github.com/GitLeeRepo/DockerNotes/blob/master/DockerNotes.md#overview)
* [MySQLGeneralNotes](https://github.com/GitLeeRepo/MySQLNotes/blob/master/MySQLGeneralNotes.md#overview)
* [UbuntuNotes](https://github.com/GitLeeRepo/UbuntuNotes/blob/master/UbuntuNotes.md#overview)


# Concepts and Terminology

**Mongo** is considered a **NoSQL database**, more specifically it is a **Document Database**.  The **documents** are stored in a **JSON like syntax**.

* **Collection** -- similar in concept to a **table** in a **relational database**.  They hold a **collection of documents**, which very loosely can be thought of as a **record** in a **table**.
* A **record** in MongoDB is a **document**, which is a data structure composed of **field and value pairs**. MongoDB **documents** are similar to **JSON objects**. 
* **NoSQL database** -- a **NoSQL** database contrasts with a **relational database** in which you have to deal **schemas, tables, columns, datatypes, etc.**.  In contrast a **NoSQL** database frees you from having to map all this stuff out in advance.  It is more **agile**.  They are also much easier to **scale** than **SQL** databases.

# Installing MongoDB on Ubuntu

* From APT repository

```
sudo apt install mongodb
```
Note: this will also install the mongodb-server, mongodb-client, mongo-tools packages, which can be installed individually instead if that is preferred.

* Getting a more recent version into the APT repository

There may be a more recent version than what is currently available to APT.  You can follow [these](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/) instructions on the MongoDB website to get the more recent version to show in your APT.  At the time of this writing they didn't have an option for Ubuntu 17.04, only earlier versions, even though the MongoDB version being offered was newer than what APT had in Ubuntu 17.04

* Starting/Stopping/Restarting the MongoDB service

```
sudo service mongod start

sudo service mongod stop

sudo service mongod restart
```

# Installing on Windows

* [Download Community Version](https://www.mongodb.com/download-center#community)
* Run the installer
* Configure MongoDB

Note: You must create the following folders before running this:

```
mongod --directoryperdb --dbpath "C:\Users\tracy\Documents\MongoDB\data\db" --logpath "C:\Users\tracy\Documents\MongoDB\log\mongo.log" --logappend --rest --install
```

* Start the service (Windows)

```
net start MongoDB
```

# Command Examples within the Mongo shell

## Start the shell

To **run the mongo shell**:

```
mongo
```

Or specify a **specific database** to **start with**:

```
mongo mydb
```

Or specify a **specific database** and **JavaScrpt** to run, followed by taking you **into the shell**:

```
mongo mydb myscript.js --shell
```

## Shell Features, Common Functions and Keystrokes

* The **shell** allows you to **enter multiline Javascript** where it recoginizes **opening braces** to enable **line continuation**, for example:

```js
> var stuff = function(name) {
... var doc = {
... Name:name,
... Created: Date(),
... Type: 'r'};
... db.foo.save(doc);
... }
> stuff("tester");

# Displaying the new document 'foo'
> db.foo.find().pretty()
{
        "_id" : ObjectId("5bd4e4ea5740883b1eac047c"),
        "Name" : "tester",
        "Created" : "Sat Oct 27 2018 22:21:30 GMT+0000 (UTC)",
        "Type" : "r"
}
```

* If you need to **edit** the prior script:

```mongo
edit stuff
```

Note you my define the **EDITOR environment variable** for this to work:

On **Linux**:

```bash
export EDITOR="vim"
```

### Common Functions

#### load()

To **load a JavaScript**

```mongo
> load("scriptName.js")
```

#### pwd()

```mongo
> pwd()
```

## Getting Help

To see what **commands** are available:


## Showing a list of database on the server

**Show the databases**:

```
show dbs
```

## To see what database your are currently in

Simply enter **db**

```mongo
db
```

Note that the **initial database** you will be in is the **test database**.

## Creating and dropping a database

* Create and switch to databases

```
use mycustomer
```

* Display current database name

```
db
```

* To drop a database

```
use test;

db.dropDatabase()
```
Drops the test database

## Creating a user in the db

* Create user

```
db.createUser( {
  user: "bob",
  pwd: "123",
  roles: [ "readWrite", "dbAdmin" ]
});
```

## Creating a collection in the current db

* Create collection (similar to tables in SQL)

```
db.createCollection("customer")
```

  Note: this **explicitly** creates the customer collection.  This command is **optional** in the sense that the collection would have been created anyway when you insert your first **document** **`db.customer.insert(params)`**

## Display a list of collections in the current db

* To **show the collections**

```
show collections
```

## Dropping Collections

* To drop a collection

```
db.customer.drop()
```

## Inserting documents

* Insert a document

```
db.customer.insert ( { first_name: "John", last_name: "Doe" } )
```

* **Insert multiple documents**

To **insert multiple documents** at a time you use **JSON like array syntax** by **enclosing in square brackets**.

```
db.customer.insert ( [{ first_name: "Mark", last_name: "Smith" }, { first_name: "Bill", last_name: "Clinton" }, { first_name: "Joan", last_name: "Jet", gender: "female" } ] )
```

Note that you can have **varying number of fields** in a collection, unlike SQL.


## Updating a Document

* To **update a document** (in this case adding a field)

```
db.customer.update ( { first_name: "John" }, { first_name: "John", last_name: "Doe", gender: "Male" } )
```

This will **update** all users with the first name "John", adding the new field.  Note you had to **repeat all the existing fields**, if you didn't do so using this context, it would have removed the fields that weren't explicitly mentioned.

To **avoid having to reset the existing fields** that didn't change in the above, use the **`$set:`** syntax instead:

```
db.customer.update ( { first_name: "Bill" }, { $set:{gender: "male"} })
```

### Using \$inc Operator with Update

You can **increment numberic values** in an **update** using the **$inc** operator

```
db.customer.update ( { first_name: "Bill" }, { $inc:{age: 2} })
```

**increments** the current **age** field by **2**.

### Removing a field in an **update** with the **\$unset** Operator

* To remove a field

```
db.customer.update ( { first_name: "Bill" }, { $unset:{gender: "male"} })
```

### Upserting a Document

To **update a document if it exists**, or **insert it if it doesn't exist** is called **upsert**.  If you don't specifcy the **`{upsert:true}`** it will only update it if it exists, and won't insert if it doesn't.

```
db.customer.update ( { first_name: "Mary" },{ first_name: "Mary", last_name: "Doe" }, {upsert:true} )
```

### Renaming a field in an **update** with the **\$rename** Operator

* To rename a field

```
db.customer.update ( { first_name: "Bill" }, { $rename:{"gender":"sex"} })
```

## Finding documents

### Displaying All the Document in a Collections

```
db.customer.find()

{ "_id" : ObjectId("59c5c6c67a1ad007f9143d09"), "first_name" : "John", "last_name" : "Doe" }
```

Note that a **unique identifier** was **automatically generated** for our **inserted document**

For a nicer format add **.pretty()** to **find()**

```
db.customer.find().pretty()
```

### Find and Display a Specific Document in a Collections

```
db.customer.find({ first_name:"Bill" }).pretty()
```

### Find and Display Mutiple Documents using the **`#or`** Operator

```
db.customer.find({ $or:[{first_name:"Bill"}, {first_name:"Cindy"}] }).pretty()
```

### Finding Based on a Condition

Find those documents with an **age < 40**

```
db.customer.find({ age:{$lt:40} }).pretty()
```

### Finding Based on Condition, Displaying Select Fields Only

In the following example, the source data has close 100 fields per document, so it can be helpful to **display a subset of the fields** in this case the **name** field. Note that **`_id:0`** is set to zero, since even when you select only a **single field** it will also display the **`_id`** unless you specifically exclude it.

```
> db.github_repos.find({updated_at:{"$gte":"2018-10-22T19:37:23Z"}},{_id:0,name:1}).pretty()
{ "name" : "DockerNotes" }
{ "name" : "ExpressJsMongoDemo01" }
{ "name" : "IdeasToDosQuestions" }
{ "name" : "NodeExpresssSandbox" }
{ "name" : "NodejsNotes" }
{ "name" : "VSCodeNotes" }
```


### Finding a Nested Value

To **find** based on a **nested value** (in this case **city** which is **nested** in the **address** object):

```
db.customer.find({ "address.city":"Boston" }).pretty()
```

Note when a **nested** value such as the **address.city** combination the **key**, in addition to the value, **needs to be in quotes**.

## Removing a document(s)

### To remove all Document that Match the Specified Value

```
db.customer.remove( { first_name: "Mary" })
```

### To delete just the first match it finds

```
db.customer.remove( { first_name: "Mary" }, {justOne:true})
```

### To remove all documents from a collection

```
db.customer.remove({})
```

## Adding Array fields or adding to an existing array

### To add or append multiple items to an array

```
db.notes.update ( 
  { title: "GitCommandNotes" }, 
  { $push:{ tag: { $each: ["Git", "Git Commands"]} } })
```
Adds "Git" and "Git Commands" to the tag array for the GitCommandNotes title.  If the tag array doesn't exist it creates and adds the array

### To add a single item to an array

```
db.notes.update ( 
  { title: "GitCommandNotes" }, 
  { $push:{ tag: "GitHub"} })
```
Adds "GitHub" to the tag array for the GitCommandNotes title.  If the tag array doesn't exists it creates and adds the array

## Removing an item from an array

Remove "GitHub" from the tag array

```
db.notes.update ( 
  { title: "GitCommandNotes" }, 
  { $pull:{ tag: { $in:["GitHub"]}} })
```
  
## Misc operations

### Sorting

```
db.customer.find().sort({last_name:1}).pretty()
```

Because of the **1** this **sorts in ascending order** based on **last_name**.  To **sort indescending order** use **-1**.

### forEach loop

```
customer.find().forEach(function(cust){ print("Name: " + cust.last_name + ', ' + cust.first_name) })
```

### To get a document count

```
db.customer.find({ gender:"male"}).count()
```

### To get a document count resulting from a conditional query

```
db.github_repos.find({size:{$lt:400}}).count()
```

# Importing and Exporting Data

## Importing JSON File

### Importing Single JSON Object (not an array)

When **importing a JSON file** that is **not** in an **array**, i.e., the file doesn't **start and end with \[ an \]**:

Example **user.json** file:

```
{
  "name":"John",
  "age":31,
}
```

```bash
$ mongoimport --db users --collection user_lead --file user.json
```

Note: this is from the **bash commandline** **not** the **mongo shell**.

### Importing JSON Array of Objects 

When **importing a JSON file** that is an **array**, i.e., the file **starts and end with \[ an \]** you need to include the **`--jsonArray`** flag. 

Example **users.json** file:

```
[
  {
    "name":"John",
    "age":31,
  },
  {
    "name":"Bill",
    "age":41,
  },
  {
    "name":"Ted",
    "age":33,
  }
]
```

**Import** including the **`--jsonArray`** flag:

```bash
$ mongoimport --db people --collection user_list --jsonArray --file users.json
```

Note: this is from the **bash commandline** **not** the **mongo shell**.

An **alternative** to using **`--jsonArray`** flag is to **add** **'{"myObjName":`** before the **opening **\[** and adding a closing **curly brace** at the **end** following the **closing \]**. 

# Mongo Scripts (JavaScript)

Refer to:

* [mongo shell scripts](https://docs.mongodb.com/manual/tutorial/write-scripts-for-the-mongo-shell/)

You can write **scripts** for the **mongo shell** using **JavaScript**

## Running Scripts from the Command Line

### Running a Command Script in a File

**Simple test.shell script**:

```mongo
use people
show collections
```

**Run script**:

```bash
mongo < test.shell
```

### Running a JavaScript from the Commandline

```bash
mongo mydb myscript.js
```

To **run a script** and then **launch the shell**:

```bash
mongo mydb myscript.js --shell
```

### Running a Script using eval

Here the database **people** is included on the commandline and **eval** uses the **printjson(db.getCollectionNames())** function to display the collections in a **JSON** format.

```bash
mongo people -eval "printjson(db.getCollectionNames())"
```

```bash
mongo --eval "printjson(db.serverStatus())"
```

## mongorc.js -- a JavaScript that runs each time Mongo is started

The **mongorc.js** in your **home directory**, in **Linux** it is a hiddent **~/.mongorc.js** file.  It already existed for me, but was empty. On **Windows** it is in **`c:\\Users\\username\.mongo.js`** with the **drive letter** being based on whatever the **HOMEDRIVE** is set to.  On both **Linux** and **Windows** the **HOME environment variable** refers to the home directory itself.

The **global mongorc.js** can be found in **/etc/mongorc.js** on **Linux**.

On the **Official Docker** image it is found in **/root/.mongon.js** since that is the default.

# Administrative Tasks

## Logs

### Log Rotation

By **default** Mongo will **keep appending to the log**.  It is a good ideas to **periodically rotate the log**.

Note this must be run on the **admin database**
```mongo
$ mongo localhost/admin --eval "db.runCommand({logRotate:1})"

MongoDB shell version v4.0.3
connecting to: mongodb://localhost:27017/admin
Implicit session: session { "id" : UUID("17d35b7d-757e-4ef0-8246-939ab15c03f2") }
MongoDB server version: 4.0.3
{ "ok" : 1 }

# OR
$ mongo localhost/admin --eval "printjson(db.runCommand({logRotate:1}))"
# In this case the same output as above
```

# Docker Specific Administrative Tasks

## Logs

### Viewing the Log

```bash
docker logs mongo01
```

If you instead want to **write the logs somewhere else** then run the following (note: I haven't veified this):

```bash
$ docker run ... mongo --logpath /somewhere/specific.log
```
