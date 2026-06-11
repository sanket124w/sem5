// MongoDB Queries: CRUD operations from dbms A3.pdf

// We'll use a students collection:
db.students.insertMany([
    { roll_no: 1, name: "Alice", course: "DBMS", marks: 85, age: 20 },
    { roll_no: 2, name: "Bob", course: "OS", marks: 75, age: 21 },
    { roll_no: 3, name: "Charlie", course: "DBMS", marks: 90, age: 22 },
    { roll_no: 4, name: "Eve", course: "AI", marks: 95, age: 20 },
    { roll_no: 5, name: "Frank", course: "OS", marks: 80, age: 23 }
]);

// 1. CREATE Operations:

// (a) Insert One Document:
db.students.insertOne({ roll_no: 6, name: "Grace", course: "AI", marks: 88, age: 21 });

// (b) Insert Many Documents:
db.students.insertMany([
    { roll_no: 7, name: "Hank", course: "DBMS", marks: 92, age: 24 },
    { roll_no: 8, name: "Ivy", course: "OS", marks: 78, age: 22 }
]);

// (c) Save Method:
// If document with roll_no:1 exists update it
// If not insert new document
// Note: .save() is deprecated. Modern equivalents are insertOne, updateOne, or replaceOne.
// This example mimics the original intent of replacing or inserting.
db.students.save({ roll_no: 1, name: "Alice", course: "DBMS", marks: 90, age: 20 });
// Modern alternative (upsert):
// db.students.updateOne(
//   { roll_no: 1 },
//   { $set: { name: "Alice", course: "DBMS", marks: 90, age: 20 } },
//   { upsert: true }
// );


// 2. READ Operations:

// (a) Find All Documents:
db.students.find();

// (b) Find One Document:
db.students.findOne({ name: "Charlie" });

// (c) Find with Condition:
db.students.find({ marks: { $gte: 85 } });

// 3. UPDATE Operations:

// (a) Update One Document:
db.students.updateOne({ roll_no: 2 }, { $set: { marks: 78 } });

// (b) Update Many Documents:
db.students.updateMany({ course: "OS" }, { $inc: { marks: 5 } });

// (c) Using Save to Update:
// As noted before, .save() is deprecated. This would replace the document.
db.students.save({ roll_no: 2, name: "Bob", course: "OS", marks: 80, age: 21 });


// 4. DELETE Operations:

// (a) Delete One Document:
db.students.deleteOne({ roll_no: 8 });

// (b) Delete Many Documents:
db.students.deleteMany({ marks: { $lt: 80 } });


// Logical Operators:

// 1) $and: Matches documents where all conditions are true.
db.students.find({ $and: [{ course: "DBMS" }, { marks: { $gte: 85 } }] });
// Simpler syntax:
// db.students.find({ course: "DBMS", marks: { $gte: 85 } });

// 2) $or: Matches documents where at least one condition is true.
db.students.find({ $or: [{ course: "DBMS" }, { marks: { $gte: 90 } }] });

// 3) $not: Negates a condition.
db.students.find({ marks: { $not: { $gte: 90 } } });
// (Finds students with marks less than 90)

// 4) $nor: Matches documents where none of the conditions are true.
db.students.find({ $nor: [{ course: "DBMS" }, { marks: { $lt: 80 } }] });
// (Students who are NOT in DBMS AND whose marks are NOT less than 80)