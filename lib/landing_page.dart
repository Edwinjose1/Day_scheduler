import 'package:day_schedule_app/scheduling_page.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  final List<String> wholeday;
  final List<String> savedSlots;
  final List<String> selectedSlots;
  final List<bool> availabilityStatus;

  LandingPage({
    required this.wholeday,
    required this.savedSlots,
    required this.selectedSlots,
    required this.availabilityStatus,
  });

  static const Map<String, String> dayAbbreviations = {
    'Sun': 'Sunday',
    'Mon': 'Monday',
    'Tues': 'Tuesday',
    'Wed': 'Wednesday',
    'Thur': 'Thursday',
    'Fri': 'Friday',
    'Sat': 'Saturday',
  };

  static const Map<String, String> timeSlotAbbreviations = {
    'morning': 'Morning',
    'afternoon': 'Afternoon',
    'evening': 'Evening',
  };

  String formatTimeSlot(String slot) {
    List<String> parts = slot.split(' ');
    String day = dayAbbreviations[parts[0]] ?? parts[0];
    String timeSlot = timeSlotAbbreviations[parts[1]] ?? parts[1];
    return '$day $timeSlot';
  }

  RichText generateAvailabilityMessage() {
    List<TextSpan> textSpans = [];
    if (wholeday.isEmpty && savedSlots.isEmpty) {
      textSpans.add(const TextSpan(
        text: 'Select your available slots',
        style: TextStyle(
          color: Color.fromARGB(255, 116, 113, 113),
          fontSize: 25,
          fontWeight: FontWeight.w400,
        ),
      ));
    } else {
      textSpans.add(const TextSpan(
        text: 'You are available in ',
        style: TextStyle(
          color: Color.fromARGB(255, 133, 130, 130),
          fontSize: 20,
          fontWeight: FontWeight.w300,
        ),
      ));

      String availableSlots = '';
      if (wholeday.isNotEmpty) {
        availableSlots +=
            '${wholeday.map((day) => dayAbbreviations[day] ?? day).join(', ')} whole day';
      }
      if (savedSlots.isNotEmpty) {
        if (availableSlots.isNotEmpty) {
          availableSlots += ', ';
        }
        availableSlots += savedSlots
            .sublist(0, savedSlots.length - 1)
            .map(formatTimeSlot)
            .join(', ');
        if (savedSlots.length > 1) {
          availableSlots += ' & ';
        }
        availableSlots += formatTimeSlot(savedSlots.last);
      }

      List<String> slotsParts = availableSlots.split(' & ');

      for (int i = 0; i < slotsParts.length; i++) {
        textSpans.add(TextSpan(
          text: slotsParts[i],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ));

        if (i < slotsParts.length - 1) {
          textSpans.add(const TextSpan(
            text: ' & ',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ));
        }
      }

      textSpans.add(const TextSpan(
        text: '.',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ));
    }

    return RichText(text: TextSpan(children: textSpans));
  }

  String getActionButtonTitlee() {
    if (wholeday.isEmpty && savedSlots.isEmpty) {
      return 'Add';
    } else if (generateAvailabilityMessage().text.toPlainText() ==
        'Select your available slots') {
      return 'Add';
    } else {
      return 'Edit';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color.fromARGB(255, 48, 22, 180),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SchedulingPage(
                availability: availabilityStatus,
                selected: selectedSlots,
              ),
            ),
          );
        },
        icon: const Icon(Icons.edit),
        label: Text(getActionButtonTitlee()),
      ),
      body: SafeArea(
        child: Column(
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
                "Hello Jose!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: Text(
                "Let's get started",
                style: TextStyle(
                  color: Color.fromARGB(255, 121, 119, 119),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: generateAvailabilityMessage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


