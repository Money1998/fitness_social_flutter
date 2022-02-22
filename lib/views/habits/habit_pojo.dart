
class Habit {
  final String userId;
  final String title;
  final String desc;

  Habit(this.userId, this.title, this.desc);
}

class Goals {
  final String name;
  final String status;

  Goals(this.name, this.status);

  @override
  String toString() {
    return '{ ${this.name}, ${this.status} }';
  }

  Goals.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        status = json['status'];

  Map<String, dynamic> toJson() => {'name': this.name, 'status': this.status};
}

class GoalUpdate {
  final String name;
  final String status;
  final String id;

  GoalUpdate(this.name, this.status,this.id);

  @override
  String toString() {
    return '{ ${this.name}, ${this.status} ,${this.id}';
  }

  GoalUpdate.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        status = json['status'],id = json['id'];

  Map<String, dynamic> toJson() => {'name': this.name, 'status': this.status, 'id': this.id};
}

