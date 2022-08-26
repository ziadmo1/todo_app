
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todos_app/firebase/tasks_data.dart';

class MyDataBase{

 static CollectionReference<Tasks> getTaskCollection(){
  return  FirebaseFirestore.instance.collection(Tasks.collectionName)
      .withConverter<Tasks>(
      fromFirestore: (snapshot,options)=>Tasks.fromFireStore(snapshot.data()??{}),
      toFirestore: (task,options)=>task.toFireStore());
  }

  static Future<void> addTask(Tasks tasks)async{
   var taskCollection = getTaskCollection();
   var doc = taskCollection.doc();
   tasks.id = doc.id;
  return doc.set(tasks);
 }

static Future<List<Tasks>> getTask()async{
   var queryData = await getTaskCollection().get();
   return queryData.docs.map((snapshot) => snapshot.data()).toList();
 }

static Stream<QuerySnapshot<Tasks>> getTaskStream(DateTime dateTime){
   var streamData = getTaskCollection()
       .where('dateTime',isEqualTo: DateUtils.dateOnly(dateTime).millisecondsSinceEpoch).snapshots();
   return streamData;
 }

 static Future<void> deleteTask(Tasks task){
   var tasksCollection = getTaskCollection().doc(task.id);
   return tasksCollection.delete();
 }

 static editTask(Tasks tasks){
   var taskRef = getTaskCollection();
   return taskRef.doc(tasks.id).update({
     'isDone' : tasks.isDone! ? false : true
   });
 }
 static Future<void> updateTask(
     Tasks tasks,){
   var updateData = getTaskCollection().doc(tasks.id).update(
     {
       'title' : tasks.title,
       'content':tasks.content,
       'dateTime' : DateUtils.dateOnly(tasks.dateTime!).millisecondsSinceEpoch,
     }
   );
   return updateData;
 }
}