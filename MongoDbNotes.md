# Overview

Notes on the MongoDB database.

# References

[Download Community Version](https://www.mongodb.com/download-center#community)

# Terminology

* A **record** in MongoDB is a **document**, which is a data structure composed of **field and value pairs**. MongoDB **documents** are similar to **JSON objects**. 
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

* To run the mongo shell

  ```
  mongo
  ```

## Showing a list of database on the server

* Show the databases

  ```
  show dbs
  ```

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

  Note: this explicitly creates the customer collection.  This command is optional in the sense that the collection would have been created anyway when you insert your first document `db.customer.insert(params)`

## Display a list of collections in the current db

* To show the collections

  ```
  show collectons
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

* Insert multiple documents

  ```
  db.customer.insert ( [{ first_name: "Mark", last_name: "Smith" }, { first_name: "Bill", last_name: "Clinton" }, { first_name: "Joan", last_name: "Jet", gender: "female" } ] )
  ```

  Note that you can have varying number of fields in a collection, unlike SQL.


## Finding documents

* To display the document in a collections

  ```
  db.customer.find()

  { "_id" : ObjectId("59c5c6c67a1ad007f9143d09"), "first_name" : "John", "last_name" : "Doe" }
  ```

Note that a unique identifier was generated for our inserted document

For a nicer format add ".pretty()" to find()

  ```
  db.customer.find().pretty()
  ```

* To find a specific match

  ```
  db.customer.find({ first_name:"Bill" }).pretty()
  ```

* To Update a document (in this case adding a field)
* To find a multiple matches

  ```
  db.customer.find({ $or:[{first_name:"Bill"}, {first_name:"Cindy"}] }).pretty()
  ```

* To find base on condition

  ```
  db.customer.find({ age:{$lt:40} }).pretty()
  ```

* To find based on a nested value:

  ```
  db.customer.find({ "address.city":"Boston" }).pretty()
  ```

  Note in this case the key, in addition to the value, needs to be in quotes.

## Misc operations

* To sort

  ```
  db.customer.find().sort({last_name:1}).pretty()
  ```

  Sorts in ascending order based on last_name.  To do descending use **-1**.

* forEach loop

  ```
  customer.find().forEach(function(cust){ print("Name: " + cust.last_name + ', ' + cust.first_name) })
  ```

* To get a document count

  ```
  db.customer.find({ gender:"male"}).count()
  ```

## Adding a field

* To Update a document (in this case adding a field)

  ```
  db.customer.update ( { first_name: "John" }, { first_name: "John", last_name: "Doe", gender: "Male" } )
  ```

  This will update all users with the first name "John", adding the new field

  To avoid having to reset the existing fields that didn't change in the above, use the following syntax instead:

  ```
  db.customer.update ( { first_name: "Bill" }, { $set:{gender: "male"} })
  ```

## Removing a field

* To remove a field

  ```
  db.customer.update ( { first_name: "Bill" }, { $unset:{gender: "male"} })
  ```

* To update a document if it exists, or add it if it doesn't (called upsert)

  ```
  db.customer.update ( { first_name: "Mary" },{ first_name: "Mary", last_name: "Doe" }, {upsert:true} )
  ```

## Renaming a field

* To rename a field

  ```
  db.customer.update ( { first_name: "Bill" }, { $rename:{"gender":"sex"} })
  ```

## Removing a document(s)

* To remove a document

  ```
  db.customer.remove( { first_name: "Mary" })
  ```

  To delete just the first match it finds

  ```
  db.customer.remove( { first_name: "Mary" }, {justOne:true})
  ```

* To remove all documents from a collection

  ```
  db.customer.remove({})
  ```

## Adding Array fields or adding to an existing array

* To add or append multiple items to an array

  ```
  db.notes.update ( 
    { title: "GitCommandNotes" }, 
    { $push:{ tag: { $each: ["Git", "Git Commands"]} } })
  ```
  Adds "Git" and "Git Commands" to the tag array for the GitCommandNotes title.  If the tag array doesn't exist it creates and adds the array

* To add a single item to an array

  ```
  db.notes.update ( 
    { title: "GitCommandNotes" }, 
    { $push:{ tag: "GitHub"} })
  ```
  Adds "GitHub" to the tag array for the GitCommandNotes title.  If the tag array doesn't exists it creates and adds the array

## Removing an item from an array

* Remove "GitHub" from the tag array

  ```
  db.notes.update ( 
    { title: "GitCommandNotes" }, 
    { $pull:{ tag: { $in:["GitHub"]}} })
  ```
