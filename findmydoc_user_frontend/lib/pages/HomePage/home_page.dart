import 'package:find_my_doc/routing/routes.dart';
import 'package:find_my_doc/universal/DoctorCard/doctor_list_card.dart';
import 'package:find_my_doc/universal/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/AuthAndUserController/user_controller.dart';
import '../../universal/AppBar/main_navbar.dart';
import '../../universal/Appointments/appointment_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          MainCustomNavbar(),

          const SizedBox(height: 20),

          // User Feeling component
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // How are you feeling today?
                  Text(
                    'How are you feeling today?',
                    style: TextStyle(
                      fontSize: largeTextFontSize.toDouble(),
                      // color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  // Spacing
                  const SizedBox(height: 15),

                  // Response Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      responseBtn('🙂', 'Relaxed'),
                      responseBtn('🫤', 'Stressed'),
                      responseBtn('🤒', 'Sick'),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25.0,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                // color: Colors.blue[100],
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Find My Doc',
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 25,
          ),

          // Categories - Horizontal ListView (dentist, etc)
          const CategoriesComponent(),

          const SizedBox(
            height: 15,
          ),

          // My Appointments Component
          MyAppointmentsComponent(),

          // Doctor list
          NearbyDoctorsTodayComponent(),

          // End Branding
          SizedBox(
            height: 250,
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Find My Doc',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[400]),
                  ),

                  // Spacing
                  const SizedBox(
                    height: 20,
                  ),

                  Text(
                    'Massive collection of Doctors, in your hands',
                    style: TextStyle(
                        fontSize: mediumBigTextFontSize.toDouble(),
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[400]),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget responseBtn(var emoji, String title, {var onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: 62,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: const Color.fromARGB(98, 255, 255, 255),
                // color: Color.fromARGB(255, 199, 199, 199),
              ),
              child: Center(
                child: Text(
                  emoji,
                  style: const TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),
            ),

            //Spacing
            const SizedBox(
              height: 8,
            ),

            // Title of the response
            Text(
              title,
              style: TextStyle(
                fontSize: bodyTextFontSize.toDouble(),
                fontWeight: FontWeight.w500,
                // color: Colors.white,
                // color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Categories Component
class CategoriesComponent extends StatelessWidget {
  const CategoriesComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          categoryBtn('lib/assets/tooth.png', 'Dentist'),
          categoryBtn('lib/assets/heart.png', 'Cardiologist'),
          categoryBtn('lib/assets/stomach.png', 'Gastroenterologist'),
          categoryBtn('lib/assets/general_pill.png', 'General Physician'),
          categoryBtn('lib/assets/brain.png', 'Neurologist'),
          categoryBtn('lib/assets/psych.png', 'Psych'),

          // See More Button
          seeMoreBtn(),

          // Right side spacing
          const SizedBox(
            width: 25,
          ),
        ],
      ),
    );
  }

  Widget categoryBtn(String assetLocation, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: GestureDetector(
        onTap: () {
          // Send the Category name that is tapped to the categories
          // page for it to fetch that specific data from the server
          Get.toNamed(Routes.getCategoryRoute(), arguments: title);
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Image.asset(
                assetLocation,
                height: 40,
              ),

              // Spacing
              const SizedBox(
                width: 10,
              ),

              // Title of the class of Doctor
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget seeMoreBtn() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.7,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Text('See More'),
          )),
    );
  }
}

// My Appointments Component
class MyAppointmentsComponent extends StatelessWidget {
  MyAppointmentsComponent({super.key});

  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    var listOfStuff = userController.getUserAppointments();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'My Appointments:',
              style: TextStyle(
                  fontSize: largeTextFontSize.toDouble(),
                  fontWeight: FontWeight.w500),
            ),
          ),

          // Spacing
          const SizedBox(
            height: 25,
          ),

          // Appointment cards
          FutureBuilder(
            future: userController.getUserAppointments(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  height: 175,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        snapshot.data != null ? snapshot.data!.length : 0,
                    itemBuilder: (context, index) {
                      var dataSnippet = snapshot.data![index];

                      return AppointmentCard(
                        doctorPFP: 'https://picsum.photos/32',
                        doctorName: dataSnippet['doctor_name'],
                        doctorSpeciality: dataSnippet['speciality'],
                        location: 'location',
                        dateTime: DateTime(2023, 4, 23, 20, 00, 0, 0, 0),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}

// Nearby Doctors Today Component
class NearbyDoctorsTodayComponent extends StatelessWidget {
  const NearbyDoctorsTodayComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Doctors Nearby Today:',
              style: TextStyle(
                  fontSize: largeTextFontSize.toDouble(),
                  fontWeight: FontWeight.w500),
            ),
          ),

          // Spacing
          const SizedBox(
            height: 25,
          ),

          // Doctor Cards (Upto 4)
          SizedBox(
            height: 320,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {
                return DoctorNearbyListCard(
                  doctorPFP: 'https://picsum.photos/32',
                  doctorName: 'Dr. Random Man',
                  doctorSpeciality: 'Nope',
                  dateTime: DateTime(2023, 4, 23, 20, 00, 0, 0, 0),
                );
              },
            ),
          ),

          // more button to view more
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'View More',
                    style: TextStyle(
                      fontSize: mediumBigTextFontSize.toDouble(),
                      fontWeight: FontWeight.w500,
                      color: Colors.blue[500],
                    ),
                  ),

                  // Spacing
                  const SizedBox(
                    width: 5,
                  ),

                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.blue[500],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
