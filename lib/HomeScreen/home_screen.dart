import 'package:flutter/material.dart';
import 'package:monitoring/API/auth_services.dart';
import 'package:monitoring/Constants/constants.dart';
import 'package:monitoring/MoodCheckIn/mood_checkin.dart';
import 'package:monitoring/Widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService().login();

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(
              text: 'Hi David, how are you?',
              fontSize: headingSize,
              textColor: headingColor,
            ),
            const SizedBox(height: 20.0),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Help your Therapist know\nhow to best support you',
                      style: TextStyle(
                        fontSize: containerText,
                        fontFamily: 'SubHeading',
                        color: subHeading,
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MoodCheckIn(),
                          ),
                        );
                      },
                      child: const Text(
                        "Take A Check-in",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: navigatorText,
                          color: Colors.white,
                          fontFamily: 'Linked',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
