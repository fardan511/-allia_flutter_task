// ignore_for_file: avoid_print

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:monitoring/API/auth_services.dart';
import 'package:monitoring/Constants/constants.dart';
import 'package:monitoring/Constants/image_string.dart';
import 'package:monitoring/FeelingLevels/feeling_levels.dart';
import 'package:monitoring/Models/model.dart';
import 'package:monitoring/Widgets/widgets.dart';

int activeIndex = 0;

class MoodCheckIn extends StatefulWidget {
  const MoodCheckIn({super.key});

  @override
  State<MoodCheckIn> createState() => _MoodCheckInState();
}

class _MoodCheckInState extends State<MoodCheckIn> {
  int? selectedQuestionId;
  int? selectedOptionId;

  List<String> myItems = [
    Images.happy,
    Images.frustrated,
    Images.sad,
    Images.angry,
    Images.peaceful,
    Images.excited,
  ];

  MoodResponse? moodResponse;
  late Future<void> _fetchQuestionsFuture;

  @override
  void initState() {
    super.initState();
    _fetchQuestionsFuture = fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    try {
      SelfReportService service = SelfReportService();
      MoodResponse response = await service.getSelfReportQuestions();
      setState(() {
        moodResponse = response;
      });
    } catch (e) {
      print("Error fetching questions: $e");
    }
  }

  void _navigateToFeelingLevels() {
    String selectedMood =
        moodResponse?.body?.first.options?[activeIndex].option ?? '';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FeelingLevels(selectedMood: selectedMood),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextWidget(
              text: moodResponse?.body?.first.question ?? 'Loading...',
              fontSize: headingSize,
              textColor: headingColor,
            ),
            const SizedBox(height: 8.0),
            TextWidget(
              text: moodResponse?.body
                      ?.firstWhere(
                        (bodyItem) => bodyItem.id == 119,
                        orElse: () => Body(question: 'Loading...'),
                      )
                      .question ??
                  'Loading...',
            ),
            const SizedBox(height: 60),
            CarouselSlider.builder(
              options: CarouselOptions(
                height: 350,
                enlargeCenterPage: true,
                aspectRatio: 1.0,
                viewportFraction: 0.8,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
              ),
              itemCount: moodResponse?.body?.first.options?.length ?? 0,
              itemBuilder: (context, index, realIndex) {
                final item = myItems[index];
                final optionText =
                    moodResponse?.body?.first.options?[index].option ?? '';
                final bool isActive = index == activeIndex;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(vertical: isActive ? 0 : 1),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: isActive ? 400 : 350,
                          height: isActive ? 400 : 330,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 150,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Image.asset(
                                    item,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              CustomTextWidget(
                                text: optionText,
                                fontSize: 40,
                                textColor: containerColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
            FutureBuilder<void>(
              future: _fetchQuestionsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: 60,
                    width: 60,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(buttonColor),
                      strokeWidth: 5,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Text("Error loading button");
                } else {
                  return CircularElevatedButton(
                    icon: Icons.arrow_forward,
                    onPressed: _navigateToFeelingLevels,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
