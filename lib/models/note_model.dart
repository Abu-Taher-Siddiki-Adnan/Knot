class NoteModel {
  String id, userId, title, desc;
  DateTime createdAt;

  NoteModel(this.id, this.userId,this.title,this.desc,this.createdAt);

  factory NoteModel.fromMap(Map<String, dynamic> map) => NoteModel(
      map['id'],
      map['user_id'],
      map['title'],
      map['desc'],
      DateTime.parse(map['created_at'])
  );

  Map<String, dynamic> toMap()=>{
    'id': id,
    'user_id': userId,
    'title': title,
    'desc': desc,
    'created_at': createdAt.toString()
  };
}

