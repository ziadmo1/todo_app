class Tasks{
  static const String collectionName = 'tasks';
  String? title;
  String? content;
  String? id;
  DateTime? dateTime;
  bool? isDone;

  Tasks({this.dateTime,this.content,this.title,this.id,this.isDone});

  Tasks.fromFireStore(Map<String,dynamic> data):this(
    title: data['title'],
    content: data['content'],
    isDone: data['isDone'],
    dateTime:DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
    id: data['id'],
  );

  Map<String,dynamic> toFireStore()=>{
    'title' : title,
    'content':content,
    'isDone' : isDone,
    'dateTime' : dateTime?.millisecondsSinceEpoch,
    'id' : id
  };
}