import 'package:flutter/material.dart';

import '../theme.dart';

class AppointmentCard extends StatelessWidget {
  final String doctorPFP;
  final String doctorName;
  final String doctorSpeciality;
  final String location;
  final DateTime dateTime;

  const AppointmentCard(
      {super.key,
      required this.doctorPFP,
      required this.doctorName,
      required this.doctorSpeciality,
      required this.location,
      required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: 300,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: secondaryThemeColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //Doctor Info
          SizedBox(
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Doctor profile picture
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    doctorPFP,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),

                // Spacing
                const SizedBox(
                  width: 10,
                ),

                // Doctor name and speciality
                SizedBox(
                  height: 50,
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          doctorName,
                          style: TextStyle(
                            fontSize: mediumBigTextFontSize.toDouble(),
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        // Spacing
                        const SizedBox(
                          height: 3,
                        ),

                        Text(
                          doctorSpeciality,
                          style: TextStyle(
                            fontSize: bodyTextFontSize.toDouble(),
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Expanded(
            child: Divider(
              thickness: 0.5,
              color: secondaryThemeColor,
            ),
          ),

          // Location and Timing
          SizedBox(
            height: 60,
            child: Expanded(
              child: Column(
                children: [
                  // Location
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: largeTextFontSize.toDouble(),
                      ),

                      // Spacing
                      const SizedBox(
                        width: 5,
                      ),

                      Text(
                        location,
                        style: TextStyle(
                          fontSize: bodyTextFontSize.toDouble(),
                          fontWeight: FontWeight.w500,
                          color: secondaryThemeColor,
                        ),
                      )
                    ],
                  ),

                  // Spacing
                  const SizedBox(
                    height: 10,
                  ),

                  // Timing
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: largeTextFontSize.toDouble(),
                      ),

                      // Spacing
                      const SizedBox(
                        width: 5,
                      ),

                      Text(
                        "${dateTime.weekday}, ${dateTime.hour}:${dateTime.minute}",
                        style: TextStyle(
                          fontSize: bodyTextFontSize.toDouble(),
                          fontWeight: FontWeight.w500,
                          color: secondaryThemeColor,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
