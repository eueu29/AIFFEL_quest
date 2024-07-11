import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'start_second.dart';
import 'friend.dart';
import 'chat.dart';
import 'user.dart';

void main() => runApp(const MyApp()); //main함수로 진입점 표시, MyApp 구동

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final List<User> users = [
      User('차은우', '얼굴천재', '이번에 워터밤 찢었는데, 혹시 봤어?', 'images/cha.jpg', '오전 1:34'),
      User('변우석', '선재업고튀어 >.<', '요즘 너무 바빴네 ㅜㅜ', 'images/rhu.jpg', '오후 5:58'),
      User('강혜윤', '마멜공주', '선재업고 튀기 성공했지롱~ :)', 'images/sol.jpg', '오후 1:00'),
      User('박보검', '**원더랜드** 개봉했어요', '오랜만이야!', 'images/park.jpg', '오후 4:23'),
      User('수지', '원더랜드 2024.06.05', '드디어 영화 개봉했어! 보러 와줄꺼지?', 'images/suji.jpg',
          '오후 6:00'),
      User('혜인', 'NewJeans_Hyein', '오늘은 내가 비눗방울 만드는 법을 알으켜줄게 ',
          'images/hyein.jpg', '오후 12:10'),
      User('하니', '팜하니', '나 무대 잘했지!!!!!', 'images/hani.jpg', '오후 6:00'),
      User('민지', 'NewJeans_Minji', 'ㅋㅋㅋㅋㅋㅋ', 'images/minji.jpg', '오전 8:00'),
    ];

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/start', // 초기화면은 Startpage로 설정
        routes: {
          // 앱 화면 등록
          '/start': (context) => const StartPage(),
          '/friend': (context) => FriendPage(users: users), // 수정된 부분
          '/chat': (context) => ChatPage(users: users)
        });
  }
}
