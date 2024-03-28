import 'package:demo_app/Controllers/appointment_controller.dart';
import 'package:demo_app/constants/color.dart';
import 'package:demo_app/constants/constants.dart';
import 'package:demo_app/models/booking_datetime_contverted.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class RescheduleAppointmentScreen extends StatefulWidget {
  final String appID;
  const RescheduleAppointmentScreen({super.key, required this.appID});

  @override
  State<RescheduleAppointmentScreen> createState() =>
      _RescheduleAppointmentScreenState();
}

class _RescheduleAppointmentScreenState
    extends State<RescheduleAppointmentScreen> {
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AppointmentController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reschedule Appointment",
          style: const TextStyle(
              fontFamily: 'Ubuntu',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: kTextColor),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      'Rescheduling the appointment will postponed till your selected new data and time slot.',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                //   child: Center(
                //     child: Text(
                //       'Select new Consultation Date',
                //       style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //           fontSize: 18,
                //           color: Colors.grey[700]),
                //     ),
                //   ),
                // ),
                _tableCalendar(),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                //   child: Center(
                //     child: Text(
                //       'Select new Consultation Slot',
                //       style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //           fontSize: 18,
                //           color: Colors.grey[700]),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          _isWeekend
              ? SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      child: Text(
                        textAlign: TextAlign.center,
                        'Weekend is not available, please select another date',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                )
              : SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            _currentIndex = index;
                            _timeSelected = true;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _currentIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: _currentIndex == index ? primaryColor : null,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${index + 9}:00 ${index + 9 > 11 ? "PM" : "AM"}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  _currentIndex == index ? Colors.white : null,
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: 8,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, childAspectRatio: 1.5),
                ),
        ],
      ),
      bottomNavigationBar: Obx(() => controller.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : GestureDetector(
              onTap: () async {
                final getDate = DateConverted.getDate(_currentDay);
                final getDay = DateConverted.getDay(_currentDay.weekday);
                final getTime = DateConverted.getTime(_currentIndex!);
                print(getTime + " " + getDay + " " + getDate);
                await controller.rescheduleAppointment(widget.appID, getDate, getDay, getTime, context);
              },
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: kTextColor,
                  ),
                  height: 60.0,
                  child: Center(
                    child: Text(
                      "Book Appointment",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                ),
              ),
            )),
    );
  }

  Widget _tableCalendar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TableCalendar(
        focusedDay: _focusDay,
        firstDay: DateTime.now(),
        lastDay: DateTime(2024, 12, 31),
        calendarFormat: _format,
        currentDay: _currentDay,
        rowHeight: 45,
        calendarStyle: const CalendarStyle(
          todayDecoration:
              BoxDecoration(color: primaryColor, shape: BoxShape.circle),
        ),
        availableCalendarFormats: const {
          CalendarFormat.month: 'Month',
        },
        onFormatChanged: (format) {
          setState(() {
            _format = format;
          });
        },
        onDaySelected: ((selectedDay, focusedDay) {
          setState(() {
            _currentDay = selectedDay;
            _focusDay = focusedDay;
            _dateSelected = true;

            //check if weekend is selected
            if (selectedDay.weekday == 6 || selectedDay.weekday == 7) {
              _isWeekend = true;
              _timeSelected = false;
              _currentIndex = null;
            } else {
              _isWeekend = false;
            }
          });
        }),
      ),
    );
  }
}
