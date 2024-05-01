class MissionModel {
  String id;
  String name;
  String description;
  String location;
  String startTime;
  String endTime;
  List<String> imageList;
  String createdDate;
  String? updateDate;

  MissionModel({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.startTime,
    required this.endTime,
    required this.imageList,
    required this.createdDate,
    this.updateDate,
  });

  factory MissionModel.fromJson(Map<String, dynamic> json) {
    return MissionModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      location: json['location'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      imageList: List<String>.from(json['imageList']),
      createdDate: json['createdDate'],
      updateDate: json['updateDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'location': location,
      'startTime': startTime,
      'endTime': endTime,
      'imageList': imageList,
      'createdDate': createdDate,
      'updateDate': updateDate,
    };
  }
}