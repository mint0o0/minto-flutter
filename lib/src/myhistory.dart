import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation:10,shape: ContinuousRectangleBorder(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(20.0), // 왼쪽 둥근 모서리
      bottomRight: Radius.circular(20.0), // 오른쪽 둥근 모서리
    ),
  ),
        backgroundColor: Color.fromARGB(255, 93, 167, 139),
        centerTitle: true,
        title: Text('축제 방문 기록',style:TextStyle(fontFamily:'GmarketSans', fontWeight:FontWeight.bold,color: Colors.white)), // 앱바에 '축제 방문 기록' 표시
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
                _focusedDay = focusedDay; // Update `_focusedDay` so the selected day is shown as focused
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          SizedBox(height: 20),
          if (_selectedDay != null)
            Text(
              '선택한 날짜: ${_selectedDay!.toString().split(' ')[0]}',
              style: TextStyle(fontSize: 18),
            ),
        ],
      ),
    );
  }
}
