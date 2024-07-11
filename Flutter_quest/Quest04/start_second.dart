import 'package:flutter/material.dart';
import 'dart:async';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  StartPageState createState() => StartPageState();
}

class StartPageState extends State<StartPage> {
  int _secondsLeft = 5;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // 타이머를 설정하여 1초마다 _secondsLeft를 감소시킴
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft > 1) {
        setState(() {
          _secondsLeft--;
        });
      } else {
        _timer.cancel();
        Navigator.pushReplacementNamed(context, '/friend');
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://mblogthumb-phinf.pstatic.net/MjAxODAyMDJfMTA5/MDAxNTE3NTAyODA4ODAz.pfFBh3N_7cDEfgp925XW22NJgDO2-2_CdhjOOJsaqjog.YUrOiE5xseldfEb3R9_y8LMPuy8o4ml5JCqLHi1yHGgg.PNG.marketstory24/%EC%B9%B4%EC%B9%B4%EC%98%A4%ED%86%A1_%EB%A1%9C%EA%B3%A0_4.png?type=w800',
            ),
            const SizedBox(height: 20),
            Text(
              'Page will change in $_secondsLeft seconds',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
