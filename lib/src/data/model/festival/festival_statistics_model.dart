class FestivalStatisticsModel {
  int visitor_male;
  int visitor_female;
  int visitor_10s;
  int visitor_20s;
  int visitor_30s;
  int visitor_40s;
  int visitor_50s_over;
  List<Map<String, int>> visitor_by_date;
  int visitor_local;
  int visitor_foreign;
  List<Map<String, int>> consumption_by_date;
  List<Map<String, int>> completed_mission_by_date;

  FestivalStatisticsModel({
    required this.visitor_male,
    required this.visitor_female,
    required this.visitor_10s,
    required this.visitor_20s,
    required this.visitor_30s,
    required this.visitor_40s,
    required this.visitor_50s_over,
    required this.visitor_by_date,
    required this.visitor_local,
    required this.visitor_foreign,
    required this.consumption_by_date,
    required this.completed_mission_by_date,
  });

  factory FestivalStatisticsModel.fromJson(Map<String, dynamic> json) {
    return FestivalStatisticsModel(
      visitor_male: json['visitor_male'],
      visitor_female: json['visitor_female'],
      visitor_10s: json['visitor_10s'],
      visitor_20s: json['visitor_20s'],
      visitor_30s: json['visitor_30s'],
      visitor_40s: json['visitor_40s'],
      visitor_50s_over: json['visitor_50s_over'],
      visitor_by_date: List<Map<String, int>>.from(json['visitor_by_date']),
      visitor_local: json['visitor_local'],
      visitor_foreign: json['visitor_foreign'],
      consumption_by_date: List<Map<String, int>>.from(
          json['consumption_by_date']),
      completed_mission_by_date: List<Map<String, int>>.from(
          json['completed_mission_by_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'visitor_male': visitor_male,
      'visitor_female': visitor_female,
      'visitor_10s': visitor_10s,
      'visitor_20s': visitor_20s,
      'visitor_30s': visitor_30s,
      'visitor_40s': visitor_40s,
      'visitor_50s_over': visitor_50s_over,
      'visitor_by_date': visitor_by_date,
      'visitor_local': visitor_local,
      'visitor_foreign': visitor_foreign,
      'consumption_by_date': consumption_by_date,
      'completed_mission_by_date': completed_mission_by_date,
    };
  }
}