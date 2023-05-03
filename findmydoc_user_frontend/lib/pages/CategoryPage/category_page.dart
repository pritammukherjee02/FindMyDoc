import 'package:find_my_doc/universal/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({super.key});

  final List args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0,
        foregroundColor: Colors.black,
        leadingWidth: 80,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      ),
      body: SafeArea(
        child: ListView(
          // physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            // Top Rated text with the text showing what kind of doctors are shown
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: Row(
                children: [
                  Image.asset(
                    args[1],
                    height: 70,
                  ),

                  // Spacing
                  const SizedBox(
                    width: 10,
                  ),

                  // Title of the class of Doctor
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Top rated',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: bodyTextFontSize.toDouble(),
                          ),
                        ),
                        Text(
                          args[0],
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Around you',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: bodyTextFontSize.toDouble(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Spacing
            const SizedBox(
              height: 10,
            ),

            // List of Doctors one by one

            // Urgent ones
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
              child: Row(
                children: [
                  Text(
                    'Urgent',
                    style: TextStyle(
                        fontSize: mediumBigTextFontSize.toDouble(),
                        fontWeight: FontWeight.w500,
                        // color: Colors.grey[600],
                        color: Colors.red[300]),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      // color: secondaryThemeColor,
                      color: Colors.red[300],
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) {
                return const DoctorListCard(
                  doctorName: 'Random Man',
                  doctorPFP: 'https://picsum.photos/32',
                  doctorSpeciality: 'Cardiologist',
                );
              },
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
              child: Divider(
                thickness: 0.5,
                // color: secondaryThemeColor,
                color: Colors.red[300],
              ),
            ),

            // Spacing
            const SizedBox(
              height: 10,
            ),

            // Normal ones
          ],
        ),
      ),
    );
  }
}

class DoctorListCard extends StatelessWidget {
  final String doctorPFP;
  final String doctorName;
  final String doctorSpeciality;
  const DoctorListCard(
      {super.key,
      required this.doctorPFP,
      required this.doctorName,
      required this.doctorSpeciality});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 2),
      child: Container(
        decoration: const BoxDecoration(
            // border: Border(
            //   bottom: BorderSide(width: 0.5, color: Colors.grey[900]!),
            // ),
            ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
