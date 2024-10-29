// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:monitoring/API/api_response.dart';
import 'package:monitoring/API/auth_services.dart';
import 'package:monitoring/Constants/constants.dart';
import 'package:monitoring/Constants/image_string.dart';
import 'package:monitoring/Models/model.dart';
import 'package:monitoring/ReportSubmission/report_submit_screen.dart';
import 'package:monitoring/Widgets/widgets.dart';

class FeelingLevels extends StatefulWidget {
  final String selectedMood;

  const FeelingLevels({super.key, required this.selectedMood});
  @override
  _FeelingLevelsState createState() => _FeelingLevelsState();
}

class _FeelingLevelsState extends State<FeelingLevels> {
  double _sliderValue = 20;
  String questionText = '';
  late Future<void> _fetchQuestionsFuture;

  final Map<String, String> moodEmojis = {
    'Happy': Images.happy,
    'Frustrated': Images.frustrated,
    'Sad': Images.sad,
    'Angry': Images.angry,
    'Peaceful': Images.peaceful,
    'Excited': Images.excited,
  };
  @override
  void initState() {
    super.initState();
    _fetchQuestionsFuture = fetchQuestionText();
  }

  Future<void> fetchQuestionText() async {
    final service = SelfReportService();
    MoodResponse response = await service.getSelfReportQuestions();
    if (response.body != null) {
      final question = response.body!.firstWhere(
        (q) => q.id == 119,
        orElse: () => Body(question: 'Question not found'),
      );
      setState(() {
        questionText = question.question ?? 'Question not found';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String? emoji = moodEmojis[widget.selectedMood];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: scaffoldBackgroundColor,
      ),
      backgroundColor: scaffoldBackgroundColor,
      body: Center(
        child: Column(
          children: [
            CustomTextWidget(
              text: "You're feeling",
              fontSize: headingSize,
              textColor: headingColor,
            ),
            CustomTextWidget(
              text: widget.selectedMood,
              fontSize: 40,
              textColor: containerColor,
            ),
            TextWidget(
              text: questionText,
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ThermometerLine(_sliderValue),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 320,
                      child: SliderTheme(
                        data: SliderThemeData(
                          thumbColor: Colors.transparent,
                          trackHeight: 20,
                          activeTrackColor: buttonColor,
                          inactiveTrackColor: slider,
                          tickMarkShape: const RoundSliderTickMarkShape(
                            tickMarkRadius: 0,
                          ),
                        ),
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Slider(
                            value: _sliderValue,
                            min: 20,
                            max: 100,
                            divisions: 8,
                            onChanged: (value) {
                              setState(() {
                                _sliderValue = (value / 10).round() * 10;
                                int id = 498 + (_sliderValue / 10).round();
                                print('ID: $id, Option: ${id - 498}');
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: (330 - (320 * (_sliderValue / 100))),
                      child: IgnorePointer(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: Center(
                            child: Image.asset(
                              emoji ?? Images.happy,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ThermometerLine(_sliderValue),
              ],
            ),
            const SizedBox(height: 40.0),
            FutureBuilder<void>(
              future: _fetchQuestionsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: 60,
                    width: 60,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(buttonColor),
                      strokeWidth: 6,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Text("Error loading data");
                } else {
                  return CircularElevatedButton(
                    icon: Icons.arrow_forward,
                    onPressed: () async {
                      // String selectedQuestionId = "your_selected_question_id";
                      // String selectedOptionId = "your_selected_option_id";
                      double sliderValue = _sliderValue;
                      // await sendFirstResponse(
                      //     selectedQuestionId, selectedOptionId);
                      await sendSecondResponse(sliderValue);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReportSubmitScreen(),
                        ),
                      );
                    },
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
