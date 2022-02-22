class Post {
  String  id;
  String title;
  String _id;
  String description;
  String status;
  String image;
  String userId;
  String type;

  Post(this.id, this.title, this._id, this.description, this.status, this.image,
      this.userId, this.type);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'title': title,
      '_id': _id,
      'description': description,
      'status': status,
      'image': image,
      'userId': userId,
      'type': type,
    };
    return map;
  }

  Post.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    _id = map['_id'];
    description = map['description'];
    status = map['status'];
    image = map['image'];
    userId = map['userId'];
    type = map['type'];
  }
}
