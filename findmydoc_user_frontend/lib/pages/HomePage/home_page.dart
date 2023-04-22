import 'package:find_my_doc/controllers/AuthAndUserController/user_controller.dart';
import 'package:find_my_doc/universal/Appointments/appointment_card.dart';
import 'package:find_my_doc/universal/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../universal/AppBar/main_navbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        MainCustomNavbar(),
        SliverToBoxAdapter(
          child: ListView(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              UserFeelingFeedbackComponent(),
              MyAppointmentsComponent()
            ],
          ),
        )
      ],
    );
  }
}

// User Feeling Feedback Widget
class UserFeelingFeedbackComponent extends StatelessWidget {
  const UserFeelingFeedbackComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[50]!, Colors.cyan[50]!]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // How are you feeling today text
          Text(
            'How are you feeling today?',
            style: TextStyle(
              fontSize: largeTextFontSize.toDouble(),
              // color: Colors.white,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),

          //Spacing
          const SizedBox(
            height: 20,
          ),

          // Buttons with emoji to take response
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              responseBtn('🙂', 'Relaxed'),
              responseBtn('🫤', 'Stressed'),
              responseBtn('🤒', 'Sick'),
            ],
          ),

          //Spacing
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  // Response Buttons with emojis
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
                color: Colors.white54,
                // color: Colors.blue[50],
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
                  color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}

// My Appointments Widget
class MyAppointmentsComponent extends StatelessWidget {
  MyAppointmentsComponent({super.key});

  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    var listOfStuff = userController.getUserAppointments();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Appointments',
            style: TextStyle(
                fontSize: largeTextFontSize.toDouble(),
                fontWeight: FontWeight.w500),
          ),

          // Spacing
          const SizedBox(
            height: 16,
          ),

          // Appointment cards
          FutureBuilder(
            future: userController.getUserAppointments(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  height: 175,
                  child: ListView.builder(
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
                          dateTime: DateTime(2023, 4, 23, 20, 0, 0, 0, 0));
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
