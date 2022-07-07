import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TestDrawer(),
    );
  }
}

class TestDrawer extends StatefulWidget {
  const TestDrawer({Key? key}) : super(key: key);

  @override
  _TestDrawerState createState() => _TestDrawerState();
}

class _TestDrawerState extends State<TestDrawer>
    with SingleTickerProviderStateMixin {
  bool isLeftCollapsed = true;
  double? screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _drawer(),
          AnimatedPositioned(
              left: isLeftCollapsed ? 0 : 319,
              right: 0,
              top: 0,
              bottom: 0,
              duration: duration,
              child: dashboard()),
        ],
      ),
    );
  }

  Widget _drawer() {
    return Positioned(
      top: 0,
      left: 0,
      bottom: 0,
      child: Container(
        color: const Color(0xFF20293A),
        width: 319,
        child: Column(children: const [
          SizedBox(
            height: 30,
          ),
          CircleAvatar(
            child: Icon(Icons.person_outline),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "User name",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 80,
          ),
        ]),
      ),
    );
  }

  Widget dashboard() {
    return Material(
      animationDuration: duration,
      elevation: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                setState(() {
                  if (isLeftCollapsed) {
                    _controller!.forward();
                  } else {
                    _controller!.reverse();
                  }
                  isLeftCollapsed = !isLeftCollapsed;
                });
              })
        ],
      ),
    );
  }
}
