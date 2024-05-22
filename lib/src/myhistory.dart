import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(MyHistory());
}

class MyHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '축제 방문 기록',
      home: FestivalVisitPage(),
    );
  }
}

class FestivalVisitPage extends StatefulWidget {
  @override
  _FestivalVisitPageState createState() => _FestivalVisitPageState();
}

class _FestivalVisitPageState extends State<FestivalVisitPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<dynamic>> _festivalVisits = {};

  @override
  void initState() {
    super.initState();
    _fetchFestivalData(_focusedDay.month);
  }

  Future<void> _fetchFestivalData(int month) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accesstoken = prefs.getString('accesstoken');
    final response = await http.get(
      Uri.parse('http://3.34.98.150:8080/member/visitFestival/$month'),
      headers:{'Authorization': 'Bearer $accesstoken'},
    );

    if (response.statusCode == 200) {
      print("myhistory에서 200뜸");
      final data = json.decode(response.body) as Map<String, dynamic>;
      print(data);
      setState(() {
        _festivalVisits = data.map((key, value) {
          
          return MapEntry(DateTime.parse(key), value as List<dynamic>);
        });
      });
    } else {
      throw Exception('Failed to load festival data');
    }
  }

  List<dynamic> _getFestivalsForDay(DateTime day) {
    return _festivalVisits[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 93, 167, 139),
        centerTitle: true,
        title: Text(
          '축제 방문 기록',
          style: TextStyle(
              fontFamily: 'GmarketSans',
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
              _fetchFestivalData(focusedDay.month);
            },
            eventLoader: _getFestivalsForDay,
          ),
          SizedBox(height: 20),
          if (_selectedDay != null && _getFestivalsForDay(_selectedDay!).isNotEmpty)
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: _getFestivalsForDay(_selectedDay!).map((festival) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 103, 84, 84),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(festival['imageList'][0]),
                          radius: 30,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            festival['name'],
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
