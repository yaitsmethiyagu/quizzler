import 'package:flutter/material.dart';
import 'quizzbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Quizzbrain quizz_brain = Quizzbrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  List<Icon> answerResult = [];
  int scores = 0;


  //to check answers (calling quizzbrain.dart)
  void checkAnswer(bool userSelectedAnswer) {
    //to show alert bar after all questions
    if (quizz_brain.isFinished == true) {
      Alert(
        context: context,
        type: AlertType.success,
        title: "Test complete",
        desc: "You reached the end of question sets. You got ${scores}, out of ${quizz_brain.totalQuestion()}.",
        buttons: [
          DialogButton(
              child: Text("Start Again"),
              color: Colors.green,
              onPressed: () {
                setState(() {
                  quizz_brain.reset();
                  answerResult.clear();
                  scores = 0 ;
                  Navigator.pop(context);
                });
              }),
        ],
      ).show();
    } else {
      //To add tick marks
      if (userSelectedAnswer == quizz_brain.getQuestionAnswer()) {
        answerResult.add(Icon(Icons.check, color: Colors.green));
        scores++;
      } else {
        answerResult.add(Icon(Icons.close, color: Colors.red));
      }
    }
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizz_brain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.green),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  checkAnswer(true);
                  quizz_brain.nextQuestion();
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  checkAnswer(false);
                  quizz_brain.nextQuestion();
                });
              },
            ),
          ),
        ),

        Row(
          children: answerResult,
        )
      ],
    );
  }
}
