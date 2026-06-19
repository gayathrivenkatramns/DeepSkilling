use college_nosql

db.createCollection("feedback")

db.feedback.insertMany([
{
student_id:1,
course_code:"CS101",
semester:"2022-ODD",
rating:5,
comments:"Excellent teaching",
tags:["challenging","well-structured","good-examples"],
submitted_at:new Date("2022-11-30T10:15:00Z"),
attachments:[{filename:"notes.pdf",size_kb:240}]
},
{
student_id:2,
course_code:"CS101",
semester:"2022-ODD",
rating:4,
comments:"Very useful",
tags:["challenging","interesting"],
submitted_at:new Date("2022-11-29T10:15:00Z"),
attachments:[{filename:"assignment.pdf",size_kb:150}]
},
{
student_id:5,
course_code:"CS101",
semester:"2022-ODD",
rating:2,
comments:"Needs improvement",
tags:["challenging","lengthy"],
submitted_at:new Date("2022-11-28T10:15:00Z"),
attachments:[{filename:"feedback.pdf",size_kb:180}]
},
{
student_id:3,
course_code:"CS102",
semester:"2022-ODD",
rating:5,
comments:"Loved DBMS",
tags:["practical","well-structured"],
submitted_at:new Date("2022-11-27T10:15:00Z"),
attachments:[{filename:"lab.pdf",size_kb:300}]
},
{
student_id:8,
course_code:"CS102",
semester:"2022-ODD",
rating:3,
comments:"Average",
tags:["database","interesting"],
submitted_at:new Date("2022-11-26T10:15:00Z"),
attachments:[{filename:"report.pdf",size_kb:120}]
},
{
student_id:4,
course_code:"ME101",
semester:"2021-EVEN",
rating:2,
comments:"Hard subject",
tags:["tough"],
submitted_at:new Date("2021-11-25T10:15:00Z"),
attachments:[{filename:"me.pdf",size_kb:140}]
},
{
student_id:6,
course_code:"EC101",
semester:"2022-ODD",
rating:4,
comments:"Good",
tags:["electronics","examples"],
submitted_at:new Date("2022-11-24T10:15:00Z"),
attachments:[{filename:"ec.pdf",size_kb:220}]
},
{
student_id:7,
course_code:"ME101",
semester:"2022-ODD",
rating:1,
comments:"Very difficult",
tags:["hard","lengthy"],
submitted_at:new Date("2022-11-23T10:15:00Z"),
attachments:[{filename:"me2.pdf",size_kb:200}]
},
{
student_id:9,
course_code:"CS103",
semester:"2022-EVEN",
rating:5,
comments:"Excellent",
tags:["oop","coding"],
submitted_at:new Date("2022-12-01T10:15:00Z"),
attachments:[{filename:"oop.pdf",size_kb:260}]
},
{
student_id:10,
course_code:"CS103",
semester:"2022-EVEN",
rating:4,
comments:"Nice",
tags:["coding","examples"],
submitted_at:new Date("2022-12-02T10:15:00Z")
}
])

db.feedback.countDocuments()

db.feedback.find({rating:5})

db.feedback.find({
course_code:"CS101",
tags:"challenging"
})

db.feedback.find(
{},
{
_id:0,
student_id:1,
course_code:1,
rating:1
}
)

db.feedback.updateMany(
{rating:{$lt:3}},
{$set:{needs_review:true}}
)

db.feedback.updateMany(
{needs_review:true},
{$push:{tags:"reviewed"}}
)

db.feedback.deleteMany({
semester:"2021-EVEN"
})

db.feedback.aggregate([
{
$match:{semester:"2022-ODD"}
},
{
$group:{
_id:"$course_code",
avg_rating:{$avg:"$rating"},
total_feedback:{$sum:1}
}
},
{
$sort:{avg_rating:-1}
}
])

db.feedback.aggregate([
{
$match:{semester:"2022-ODD"}
},
{
$group:{
_id:"$course_code",
avg_rating:{$avg:"$rating"},
total_feedback:{$sum:1}
}
},
{
$project:{
_id:0,
course_code:"$_id",
average_rating:{$round:["$avg_rating",1]},
total_feedback:1
}
},
{
$sort:{average_rating:-1}
}
])

db.feedback.aggregate([
{
$unwind:"$tags"
},
{
$group:{
_id:"$tags",
count:{$sum:1}
}
},
{
$sort:{count:-1}
}
])

db.feedback.createIndex({
course_code:1
})

db.feedback.find({
course_code:"CS101"
}).explain("executionStats")