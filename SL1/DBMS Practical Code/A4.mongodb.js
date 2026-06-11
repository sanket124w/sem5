// MongoDB - Aggregation, Indexing, and Map-Reduce from dbms A4 .pdf

// Let's assume a students collection:
db.students.insertMany([
    { name: "Alice", course: "DBMS", marks: 85 },
    { name: "Charlie", course: "DBMS", marks: 90 },
    { name: "Bob", course: "OS", marks: 75 },
    { name: "Eve", course: "OS", marks: 80 },
    { name: "Frank", course: "AI", marks: 95 }
]);

// Aggregation Examples:

// (a) Match - filter documents
db.students.aggregate([
    { $match: { course: "DBMS" } }
]);

// (b) Group with $avg - average marks per course
db.students.aggregate([
    { $group: { _id: "$course", avgMarks: { $avg: "$marks" } } }
]);

// (c) Group with $sum - total marks per course
db.students.aggregate([
    { $group: { _id: "$course", totalMarks: { $sum: "$marks" } } }
]);

// (d) Sort - highest marks first (Descending order)
db.students.aggregate([
    { $sort: { marks: -1 } }
]);

// (e) Project - show only name and marks
db.students.aggregate([
    { $project: { _id: 0, name: 1, marks: 1 } }
]);


// Indexing in MongoDB:

// (a) Create a single field index
db.students.createIndex({ course: 1 });

// (b) Create a compound index
db.students.createIndex({ course: 1, marks: -1 });

// (c) View all indexes
db.students.getIndexes();

// (d) Drop an index
db.students.dropIndex({ course: 1 });

// (e) Use of index (This query would use the index on 'course')
db.students.find({ course: "DBMS" });


// Map-Reduce operation in MongoDB
// Note: Map-Reduce is generally considered legacy. Aggregation Pipeline is preferred.
// This code is from the PDF for completeness.

// 1. Insert sample data (if not already present)
/*
db.students.insertMany([
    { name: "Alice", course: "DBMS", marks: 85 },
    { name: "Charlie", course: "DBMS", marks: 90 },
    { name: "Bob", course: "OS", marks: 75 },
    { name: "Frank", course: "AI", marks: 95 },
    { name: "Eve", course: "OS", marks: 80 }
]);
*/

// 2. Define the Map function
var mapFunction = function() {
    emit(this.course, this.marks);
};

// 3. Define the Reduce function
var reduceFunction = function(course, marksArray) {
    return Array.sum(marksArray); // sum all marks for each course
};

// 4. Run Map-reduce and save results in a new collection
db.students.mapReduce(
    mapFunction,
    reduceFunction,
    { out: "total_marks_per_course" }
);

// 5. View results
db.total_marks_per_course.find();