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
