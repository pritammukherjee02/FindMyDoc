import 'package:find_my_doc/universal/theme.dart';
import 'package:flutter/material.dart';

class DoctorNearbyListCard extends StatelessWidget {
  final String doctorPFP;
  final String doctorName;
  final String doctorSpeciality;
  final DateTime dateTime;

  const DoctorNearbyListCard(
      {super.key,
      required this.doctorPFP,
      required this.doctorName,
      required this.doctorSpeciality,
      required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Doctor Image
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
              width: 12,
            ),

            // Doctor Name and Speciality
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    doctorName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
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
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: bodyTextFontSize.toDouble(),
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),

            // Time
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.access_time_rounded,
                  size: largeTextFontSize.toDouble(),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  '12:45',
                  style: TextStyle(
                    fontSize: mediumBigTextFontSize.toDouble(),
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
