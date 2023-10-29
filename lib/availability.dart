import 'package:day_schedule_app/color_const.dart';
import 'package:flutter/material.dart';

class AvailabilityWidget extends StatefulWidget {
  final List<bool> availabilityStatus;
  final List<String> selectedSlots;
  final List<String> unavailableDays;

  AvailabilityWidget(
      {required this.availabilityStatus,
      required this.selectedSlots,
      required this.unavailableDays});

  @override
  State<AvailabilityWidget> createState() => _AvailabilityWidgetState();
}

class _AvailabilityWidgetState extends State<AvailabilityWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          var day = ['Sun', 'Mon', 'Tues', 'Wed', 'Thur', 'Fri', 'Sat'][index];
          return Column(
            children: [
              //  Divider(thickness: 1.5), // Divider between days
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.availabilityStatus[index * 3] =
                          !widget.availabilityStatus[index * 3];
                      widget.availabilityStatus[index * 3 + 1] =
                          !widget.availabilityStatus[index * 3 + 1];
                      widget.availabilityStatus[index * 3 + 2] =
                          !widget.availabilityStatus[index * 3 + 2];

                      String dayName = [
                        'Sun',
                        'Mon',
                        'Tues',
                        'Wed',
                        'Thur',
                        'Fri',
                        'Sat'
                      ][index];

                      if (!widget.availabilityStatus[index * 3]) {
                        if (!widget.unavailableDays.contains(dayName)) {
                          widget.unavailableDays.add(dayName);
                        }
                      } else {
                        widget.unavailableDays.remove(dayName);
                      }
                    });
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.grey)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: widget.availabilityStatus[index * 3]
                                  ? const Color.fromARGB(255, 37, 122, 40)
                                  : const Color.fromRGBO(158, 158, 158, 1),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.check,
                                size: 13.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            day,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 6),
                          if (widget.availabilityStatus[index * 3])
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if (widget.selectedSlots[index * 3] ==
                                              'Morning') {
                                            widget.selectedSlots[index * 3] =
                                                '';
                                          } else {
                                            widget.selectedSlots[index * 3] =
                                                'Morning';
                                          }
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            widget.selectedSlots[index * 3] ==
                                                    'Morning'
                                                ? Colors.transparent
                                                : Colors.transparent,
                                        foregroundColor: Colors.black,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12.0,
                                          horizontal: 16.0,
                                        ),
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w100,
                                          fontSize: 14,
                                        ),
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        side: BorderSide(
                                          color: widget.selectedSlots[
                                                      index * 3] ==
                                                  'Morning'
                                              ? Colorconst.Sbcolor
                                              // Change color for selected slot
                                              : Colorconst.Ubcolor,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Text('Morning',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: widget.selectedSlots[
                                                          index * 3] ==
                                                      'Morning'
                                                  ? Colorconst.Sbcolor
                                                  : Colorconst.Ubcolor)),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if (widget.selectedSlots[
                                                  index * 3 + 1] ==
                                              'Afternoon') {
                                            widget.selectedSlots[
                                                index * 3 + 1] = '';
                                          } else {
                                            widget.selectedSlots[
                                                index * 3 + 1] = 'Afternoon';
                                          }
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: widget.selectedSlots[
                                                    index * 3 + 1] ==
                                                'Afternoon'
                                            ? Colors.transparent
                                            : Colors.transparent,
                                        foregroundColor: Colors.black,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12.0,
                                          horizontal: 16.0,
                                        ),
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w100,
                                          fontSize: 14,
                                        ),
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        side: BorderSide(
                                          color: widget.selectedSlots[
                                                      index * 3 + 1] ==
                                                  'Afternoon'
                                              ? Colorconst.Sbcolor
                                              : Colorconst.Ubcolor,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Text('Afternoon',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: widget.selectedSlots[
                                                          index * 3 + 1] ==
                                                      'Afternoon'
                                                  ? Colorconst.Sbcolor
                                                  : Colorconst.Ubcolor)),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if (widget.selectedSlots[
                                                  index * 3 + 2] ==
                                              'Evening') {
                                            widget.selectedSlots[
                                                index * 3 + 2] = '';
                                          } else {
                                            widget.selectedSlots[
                                                index * 3 + 2] = 'Evening';
                                          }
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: widget.selectedSlots[
                                                    index * 3 + 2] ==
                                                'Evening'
                                            ? Colors.transparent
                                            : Colors.transparent,
                                        foregroundColor: Colors.black,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12.0,
                                          horizontal: 16.0,
                                        ),
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w100,
                                          fontSize: 14,
                                        ),
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        side: BorderSide(
                                          color: widget.selectedSlots[
                                                      index * 3 + 2] ==
                                                  'Evening'
                                              ? Colorconst.Sbcolor
                                              : Colorconst.Ubcolor,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Text('Evening',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: widget.selectedSlots[
                                                          index * 3 + 2] ==
                                                      'Evening'
                                                  ? Colorconst.Sbcolor
                                                  : Colorconst.Ubcolor)),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          else
                            const Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(width: 30),
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      'Unavailable',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 132, 131, 131),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150,
                                  )
                                ],
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
