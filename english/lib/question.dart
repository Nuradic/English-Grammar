import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Question {
  String? correct;
  String? question;
  List<String> choices = [];
  List<bool> isAnswer = [false, false, false, false];
  Question({required this.correct, required this.question, required choose}) {
    for (int i = 0; i < 4; i++) {
      choices.add(choose[i]['#text']);
    }
    checkAnswer();
  }
  checkAnswer() {
    for (int i = 0; i < 4; i++) {
      if (correct == '${i + 1}') {
        isAnswer[i] = true;
      }
    }
  }
}

////////////////////////////////////////////////////////////////////////////////
class QA extends StatefulWidget {
  final String test;
  const QA({Key? key, required this.test}) : super(key: key);

  @override
  State<QA> createState() => _QAState();
}

class _QAState extends State<QA> {
  List<dynamic> qst = [];

  List<Question> questions = [];

  List num = [];
  Future loadjson() async {
    String tempstr =
        await DefaultAssetBundle.of(context).loadString(widget.test);
    qst = jsonDecode(tempstr);
    for (int i = 0; i < qst.length; i++) {
      num.add([false, false, false, false, false]);
      questions.add(
        Question(
            choose: qst[i]['ans'],
            correct: qst[i]['@correct'],
            question: qst[i]['#text']),
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    loadjson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text("Choose the Best answer"),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
          backgroundColor:
              // Colors.transparent
              const Color.fromARGB(255, 12, 155, 150),
        ),
        body: getQuestion());
  }

  bool checkAnswer({required answer, required number}) {
    if (answer == number) {
      return true;
    }
    return false;
  }

  Widget getQuestion() {
    var deviceData = MediaQuery.of(context);
    bool isPort = deviceData.orientation == Orientation.portrait;
    double _height = isPort ? deviceData.size.height : deviceData.size.width;
    double _width = isPort ? deviceData.size.width : deviceData.size.height;
    return AnimationLimiter(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        itemCount: qst.length,
        itemBuilder: ((context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            delay: const Duration(milliseconds: 100),
            child: SlideAnimation(
              duration: const Duration(milliseconds: 2500),
              curve: Curves.fastLinearToSlowEaseIn,
              child: FadeInAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                duration: const Duration(milliseconds: 2500),
                child: Container(
                  margin: EdgeInsets.only(
                      left: isPort ? 10 : 100,
                      right: isPort ? 10 : 100,
                      top: 10,
                      bottom: 10),
                  // width: _width * 0.5,
                  height: _height * 0.5,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 25,
                          offset: Offset(5, 10))
                    ],
                    color: Color.fromARGB(255, 12, 155, 150), //rgb(12,155,150)
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: _width * 0.9,
                        height: _height * 0.1,
                        decoration: const BoxDecoration(
                          color:
                              Color.fromARGB(120, 66, 66, 66), //rgb(66,66,66)
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        alignment: Alignment.topLeft,
                        margin:
                            const EdgeInsets.only(top: 30, left: 12, right: 8),
                        padding:
                            const EdgeInsets.only(top: 20, left: 10, right: 10),
                        child: Text(
                          " ${index + 1}. ${questions[index].question}",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 218, 218, 218)),
                        ),
                      ),
                      choice(index: index, secIndx: 0),
                      choice(index: index, secIndx: 1),
                      choice(index: index, secIndx: 2),
                      choice(index: index, secIndx: 3),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget choice({required int index, required secIndx}) {
    var deviceData = MediaQuery.of(context);
    double _height = deviceData.orientation == Orientation.portrait
        ? deviceData.size.height
        : deviceData.size.width;
    double _width = deviceData.orientation == Orientation.portrait
        ? deviceData.size.width
        : deviceData.size.height;
    // print(deviceData.orientation);
    String? content;
    if (secIndx == 0) {
      content = "A. ${questions[index].choices[secIndx]}";
    } else if (secIndx == 1) {
      content = "B. ${questions[index].choices[secIndx]}";
    } else if (secIndx == 2) {
      content = "C. ${questions[index].choices[secIndx]}";
    } else {
      content = "D. ${questions[index].choices[secIndx]}";
    }

    return Container(
      margin: EdgeInsets.all(_height * 0.008),
      child: ElevatedButton(
        onPressed: () {
          if (!num[index][4]) {
            num[index][4] = true;
          }
          if (!questions[index].isAnswer[secIndx]) {
            num[index][secIndx] = true;
          } else {
            num[index][0] = true;
            num[index][1] = true;
            num[index][2] = true;
            num[index][3] = true;
          }

          setState(() {});
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            content,
            style: const TextStyle(
              color: Color.fromARGB(255, 218, 218, 218),
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          primary: answerAuth(index, secIndx),
          elevation: 5,
          fixedSize: Size(_width * 0.8, _height * 0.06),
        ),
      ),
    );
  }

  answerAuth(int index, int secIndx) {
    if (num[index][4]) {
      if (questions[index].isAnswer[secIndx]) {
        return Colors.green;
      } else if (num[index][secIndx]) {
        return Colors.red;
      } else {
        return Colors.white.withOpacity(0.4);
      }
    } else {
      return Colors.white.withOpacity(0.4);
    }
  }
}
