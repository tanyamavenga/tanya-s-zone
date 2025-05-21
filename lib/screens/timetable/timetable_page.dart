import 'package:authentication_page/screens/timetable/widgets/badge.dart';
import 'package:authentication_page/screens/timetable/widgets/day_select.dart';
import 'package:authentication_page/screens/timetable/widgets/schedule.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  DateTime _selectedDate = DateTime.now();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _getDayName(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('TimeTable'),
            Text(
              DateFormat('MMMM y').format(_selectedDate),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const NotificationBadge(),
            onPressed: () {

            },
          ),
        ],
      ),
      body: Column(
        children: [

          DaySelector(
            selectedDate: _selectedDate,
            onDateSelected: (date) => setState(() => _selectedDate = date),
          ),


          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('timetable')
                  .where('day', isEqualTo: _getDayName(_selectedDate))
                  .orderBy('startTime')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.event_available, size: 60, color: Colors.grey.shade300),
                        const SizedBox(height: 16),
                        Text(
                          'No classes today',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final doc = snapshot.data!.docs[index];


                      final startTime = (doc['startTime'] as Timestamp).toDate();
                      final endTime = (doc['endTime'] as Timestamp).toDate();


                      final formattedStartTime = DateFormat('hh:mm a').format(startTime);
                      final formattedEndTime = DateFormat('hh:mm a').format(endTime);

                      return ScheduleCard(
                        courseName: doc['courseName'],
                        room: doc['room'],
                        teacher: doc['teacher'],
                        startTime: formattedStartTime, // Pass as String
                        endTime: formattedEndTime,     // Pass as String
                        color: Colors.primaries[index % Colors.primaries.length],
                      );
                    }

                );
              },
            ),
          ),
        ],
      ),
    );
  }
}