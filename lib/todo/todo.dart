class Todo {
  late int id;
  late String title;
  late String detail;
  late bool done;
  late String createDate;
  late String updateDate;

  Todo(this.id, this.title, this.detail, this.done, this.createDate,
      this.updateDate);

  Map toJson() {
    return {
      'id': id,
      'title': title,
      'detail': detail,
      'done': done,
      'createDate': createDate,
      'updateDate': updateDate
    };
  }

  Todo.fromJson(Map json) {
    id = json['id'];
    title = json['title'];
    detail = json['detail'];
    done = json['done'];
    createDate = json['createDate'];
    updateDate = json['updateDate'];
  }
}
