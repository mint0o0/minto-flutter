import 'package:minto/src/data/model/mission/mission_model.dart';

class FestivalModel {
  final String name;
  final String startTime;
  final String endTime;
  final List<String> imageList;
  final String location;
  final String description;
  final List<MissionModel> missions;
  final String createdDate;
  final String? updateDate;

  FestivalModel({
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.imageList,
    required this.location,
    required this.description,
    required this.missions,
    required this.createdDate,
    this.updateDate,
  });

  factory FestivalModel.fromJson(Map<String, dynamic> json) {
    return FestivalModel(
      name: json['name'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      imageList: List<String>.from(json['imageList']),
      location: json['location'],
      description: json['description'],
      missions: List<MissionModel>.from(
          json['missions'].map((x) => MissionModel.fromJson(x))),
      createdDate: json['createdDate'],
      updateDate: json['updateDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'startTime': startTime,
      'endTime': endTime,
      'imageList': imageList,
      'location': location,
      'description': description,
      'missions': missions.map((x) => x.toJson()).toList(),
      'createdDate': createdDate,
      'updatedDate': updateDate,
    };
  }
}