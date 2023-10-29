import 'package:day_schedule_app/landing_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LandingPage(
          wholeday: const [],
          savedSlots:const  [],
          selectedSlots:const  [],
          availabilityStatus: const[],
        ));
  }
}
