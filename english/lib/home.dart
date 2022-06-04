import 'package:english/question.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter.io/url_launcher';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void navigate({required String test}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Home2(subdir: test);
        },
      ),
    );
  }

  void _launch(String url) async {
    var _url = Uri.parse(url);
    if (!await launchUrl(_url)) throw 'could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);
    double _height = deviceData.orientation == Orientation.portrait
        ? deviceData.size.height
        : deviceData.size.width;
    double _width = deviceData.orientation == Orientation.portrait
        ? deviceData.size.width
        : deviceData.size.height;
    // print(_width);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 155, 150),
        title: const Text("Oxford Advanced English Grammar "),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(children: [
            Image(
              width: _width,
              height: _height * 0.3,
              image: const AssetImage('assets/images/study.png'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                navigate(test: 'new');
              },
              child: const Text('Advanced New', style: TextStyle(fontSize: 30)),
              style: ElevatedButton.styleFrom(
                  primary: Colors.orangeAccent,
                  fixedSize: Size(_width * 0.5, _height * 0.2),
                  elevation: 8),
            ),
            SizedBox(
              height: _height * 0.05,
            ),
            ElevatedButton(
              onPressed: () {
                navigate(test: 'old');
              },
              child: const Text('Advanced Old', style: TextStyle(fontSize: 30)),
              style: ElevatedButton.styleFrom(
                  primary: Colors.orangeAccent,
                  fixedSize: Size(_width * 0.5, _height * 0.2),
                  elevation: 8),
            ),
            const SizedBox(height: 20),
          ]),
        ),
      ),
      drawer: Drawer(
          child: Column(children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/drawerimg.png'),
            ),
          ),
          // decoration: ,
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Text("Practice Grammar App from TemariCo")),
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(300, 100),
              primary: const Color.fromARGB(255, 12, 155, 150),
            ),
            onPressed: () {
              _launch('http://TemariCo.ezyro.com');
            },
            icon: const Icon(
              Icons.telegram,
              size: 50,
            ),
            label: const Text(
              "Join us on Telegram at @TemariCo for more Resources Of Grade 12 Exams",
            ),
          ),
        )
      ])),
    );
  }
}

class Home2 extends StatefulWidget {
  String subdir;
  Home2({Key? key, required this.subdir}) : super(key: key);

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  void navigate({required String test}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return QA(test: test);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);
    double _height = deviceData.orientation == Orientation.portrait
        ? deviceData.size.height
        : deviceData.size.width;
    double _width = deviceData.orientation == Orientation.portrait
        ? deviceData.size.width
        : deviceData.size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 155, 150),
        title: const Text('English Grammar Exercise'),
      ),
      body: Center(
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            Image(
              width: _width,
              height: _height * 0.5,
              image: const AssetImage('assets/images/study.png'),
            ),
            SizedBox(height: _height * 0.001),
            ElevatedButton(
              onPressed: () {
                navigate(test: 'assets/json/${widget.subdir}/test12.json');
              },
              child: const Text('Test 1', style: TextStyle(fontSize: 30)),
              style: ElevatedButton.styleFrom(
                  primary: Colors.orangeAccent,
                  fixedSize: Size(_width * 0.3, _height * 0.1),
                  elevation: 8),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                navigate(test: 'assets/json/${widget.subdir}/test22.json');
              },
              child: const Text('Test 2', style: TextStyle(fontSize: 30)),
              style: ElevatedButton.styleFrom(
                  primary: Colors.orangeAccent,
                  fixedSize: Size(_width * 0.3, _height * 0.1),
                  elevation: 8),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                navigate(test: 'assets/json/${widget.subdir}/test32.json');
              },
              child: const Text('Test 3', style: TextStyle(fontSize: 30)),
              style: ElevatedButton.styleFrom(
                  primary: Colors.orangeAccent,
                  fixedSize: Size(_width * 0.3, _height * 0.1),
                  elevation: 8),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                navigate(test: 'assets/json/${widget.subdir}/test42.json');
              },
              child: const Text('Test 4', style: TextStyle(fontSize: 30)),
              style: ElevatedButton.styleFrom(
                  primary: Colors.orangeAccent,
                  fixedSize: Size(_width * 0.3, _height * 0.1),
                  elevation: 8),
            ),
          ],
        ),
      ),
    );
  }
}
