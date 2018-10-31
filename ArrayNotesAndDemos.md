# Overview

Notes on creating and using arrays in Mongo, with demos

# References

## My Other Notes

* [MongoDbNotes](https://github.com/GitLeeRepo/MongoDBNotes/blob/master/MongoDbNotes.md#overview)

# Combining Arrays

Refer to:

* [aggregation-pipeline Mongo Reference](https://docs.mongodb.com/manual/reference/operator/aggregation-pipeline/)
* [\$concatArrays Mongo Reference](https://docs.mongodb.com/manual/reference/operator/aggregation/concatArrays/) -- for combining the arrays
* [\$out Mongo Reference](https://docs.mongodb.com/manual/reference/operator/aggregation/out/index.html) -- for creating a new collection from the combined output

## Operators used in this section

* **\$concatArrays** -- 
* **\$out** -- 

## Demo Script

```
use arrayDemo
```

```js
// drop collections if they exist
db.warehouse.drop();
db.combined.drop();

db.warehouse.insert([{ "_id" : 1, instock: [ "chocolate" ], ordered: [ "butter", "apples" ] },
                    { "_id" : 2, instock: [ "apples", "pudding", "pie" ] },
                    { "_id" : 3, instock: [ "pears", "pecans"], ordered: [ "cherries" ] },
                     { "_id" : 4, instock: [ "ice cream" ], ordered: [ ] }]);

// display
print('warehouse insert results');
db.warehouse.find().forEach(printjson)

// output to screen
db.warehouse.aggregate([{ $project: { items: { $concatArrays: [ "$instock", "$ordered" ] } } } ]);

// insert to document
db.warehouse.aggregate([{ $project: { items: { $concatArrays: [ "$instock", "$ordered" ] } } },{$out:"combined"}]);

// display
print('combined arrays insert results');
db.combined.find().forEach(printjson)
```
