class Todo {
  late int id;
  late String title;
  late String explanation;
  late bool done;
  late String createDate;
  late String updatedDate;

  Todo(this.id, this.title, this.explanation, this.done, this.createDate,
      this.updatedDate);

  Map toJson() {
    return {
      'id': id,
      'title': title,
      'explanation': explanation,
      'done': done,
      'createDate': createDate,
      'updatedDate': updatedDate
    };
  }

  factory Todo.fromJson(Map json) {
    return Todo(
      json['id'],
      json['title'],
      json['explanation'],
      json['done'],
      json['createDate'],
      json['updatedDate'],
    );
  }
}
