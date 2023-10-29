import 'package:day_schedule_app/availability.dart';
import 'package:day_schedule_app/landing_page.dart';
import 'package:day_schedule_app/save_button.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SchedulingPage extends StatefulWidget {
  late List<String> selected;
  late List<bool> availability;
  SchedulingPage(
      {super.key, required this.selected, required this.availability});

  @override
  // ignore: library_private_types_in_public_api
  _SchedulingPageState createState() => _SchedulingPageState();
}

class _SchedulingPageState extends State<SchedulingPage> {
  List<bool> availabilityStatus = List.filled(21, true);
  List<String> selectedSlots = List.filled(21, '');
  List<String> savedSlots = [];
  List<String> wholeday = [];
  List<String> unavailableDays = [];
  @override
  void initState() {
    super.initState();
    // ignore: unnecessary_null_comparison
    if (widget.selected != null && widget.selected.length == 21) {
      selectedSlots = List.from(widget.selected);
    }
    if (widget.availability != null && widget.availability.length == 21) {
      availabilityStatus = List.from(widget.availability);
    } else {
      availabilityStatus = List.filled(21, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/images/neo-io-logo-vector.png',
                width: 60,
                height: 60,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(14, 4, 14, 14),
              child: Text(
                "Set your weekly hours",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1.0, color: Colors.grey)),
              ),
            ),
            AvailabilityWidget(
                availabilityStatus: availabilityStatus,
                selectedSlots: selectedSlots,
                unavailableDays: unavailableDays),
            Container(
                width: double.infinity,
                height: .3,
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10.0,
                      spreadRadius: 1.0,
                      offset: Offset(
                        5.0,
                        5.0,
                      ),
                    )
                  ],
                )),
            Container(
              margin: const EdgeInsets.all(16.0),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 206, 196, 196)
                        .withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: SaveButton(
                onPressed: () => handleSaveButtonPress(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleSaveButtonPress(BuildContext context) {
    List<String> displaySlots = [];
    for (int i = 0; i < selectedSlots.length; i++) {
      if (selectedSlots[i].isNotEmpty) {
        String day =
            ['Sun', 'Mon', 'Tues', 'Wed', 'Thur', 'Fri', 'Sat'][i ~/ 3];
        String slot = selectedSlots[i];
        String timeSlot = '$day $slot';
        displaySlots.add(timeSlot);
      }
    }
    List<String> daysWithAllSlotsSelected = [];
    for (int index = 0; index < 7; index++) {
      bool isWholeDaySelected = true;
      for (int i = 0; i < 3; i++) {
        if (selectedSlots[index * 3 + i].isEmpty) {
          isWholeDaySelected = false;
          break;
        }
      }
      if (isWholeDaySelected) {
        daysWithAllSlotsSelected
            .add(['Sun', 'Mon', 'Tues', 'Wed', 'Thur', 'Fri', 'Sat'][index]);
      }
    }
    List<String> updatedDisplaySlots = [];
    for (String slot in displaySlots) {
      bool shouldIncludeSlot = true;
      for (String day in daysWithAllSlotsSelected) {
        if (slot.startsWith(day)) {
          shouldIncludeSlot = false;
          break;
        }
      }
      if (shouldIncludeSlot) {
        updatedDisplaySlots.add(slot);
      }
    }
    for (String dayToRemove in unavailableDays) {
      daysWithAllSlotsSelected.remove(dayToRemove);
      updatedDisplaySlots.removeWhere((slot) => slot.startsWith(dayToRemove));
    }
    setState(() {
      savedSlots = updatedDisplaySlots;
      wholeday = daysWithAllSlotsSelected;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LandingPage(
          wholeday: wholeday,
          savedSlots: savedSlots,
          selectedSlots: selectedSlots,
          availabilityStatus: availabilityStatus,
        ),
      ),
    );
  }
}
