class BucketTemplate {
  int? cloneCount;
  String? description;
  String? scope;
  String? category;
  String? title;
  String? deadline;
  List<String>? tasks;
  bool? isCompleted;

  BucketTemplate(
      {this.cloneCount,
      this.description,
      this.scope,
      this.category,
      this.title,
      this.deadline,
      this.tasks,
      this.isCompleted});

  BucketTemplate.fromJson(Map<String, dynamic> json) {
    cloneCount = json['cloneCount'];
    description = json['description'];
    scope = json['scope'];
    category = json['category'];
    title = json['title'];
    deadline = json['deadline'].toDate().toString();
    tasks = json['tasks'].cast<String>();
    isCompleted = json['isCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cloneCount'] = cloneCount;
    data['description'] = description;
    data['scope'] = scope;
    data['category'] = category;
    data['title'] = title;
    data['deadline'] = deadline;
    data['tasks'] = tasks;
    data['isCompleted'] = isCompleted;
    return data;
  }
}
