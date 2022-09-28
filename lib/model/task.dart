class TaskModel {
  int? color, remind, isCompleted;
  String? title, note, date, startTime, endTime, repeat;
  int? id;

  TaskModel({
    this.id,
    this.color,
    this.remind,
    this.isCompleted,
    this.title,
    this.note,
    this.date,
    this.startTime,
    this.endTime,
    this.repeat,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    color = json['color'];
    remind = json['remind'];
    isCompleted = json['isCompleted'];
    title = json['title'];
    note = json['note'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    repeat = json['repeat'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['color'] = color;
    data['remind'] = remind;
    data['isCompleted'] = isCompleted;
    data['title'] = title;
    data['note'] = note;
    data['date'] = date;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['repeat'] = repeat;
    return data;
  }

  @override
  String toString() {
    return 'TaskModel{id: $id,color: $color,remind: $remind,isCompleted: $isCompleted,title: $title,note: $note,date: $date,startTime: $startTime,endTime: $endTime,repeat: $repeat}';
  }
}
