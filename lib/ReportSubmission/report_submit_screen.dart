import 'package:flutter/material.dart';
import 'package:monitoring/Constants/constants.dart';
import 'package:monitoring/Constants/image_string.dart';
import 'package:monitoring/HomeScreen/home_screen.dart';
import 'package:monitoring/Widgets/widgets.dart';

class ReportSubmitScreen extends StatelessWidget {
  const ReportSubmitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Images.thumbsUp,
              height: MediaQuery.of(context).size.height * 0.30,
            ),
            CustomTextWidget(
              text: 'Self report completed',
              fontSize: headingSize,
              textColor: headingColor,
            ),
            const SizedBox(height: 15.0),
            CustomWRectangleButton(
              text: 'Go to Home',
              color: buttonColor,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
