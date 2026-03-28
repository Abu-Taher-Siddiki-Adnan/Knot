class UserModel {
  String id, name, email;
  DateTime createdAt;

  UserModel(this.id, this.name, this.email, this.createdAt);

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
    map['id'],
    map['name'],
    map['email'],
    DateTime.parse(map['created_at']),
  );

  Map<String, dynamic> toMap() => {
    'id' : id,
    'name' : name,
    'email' : email,
    'created_at' : createdAt.toString()
  };
}
