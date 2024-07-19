import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'start_second.dart';
import 'friend.dart';
import 'chatlist.dart';
import 'chat.dart';
import 'user.dart';
import 'gridpage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final List<User> users = [
      User('차은우', '얼굴천재', [Message('이번에 워터밤 찢었는데, 혹시 봤어?', false)], 'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbOtdfT%2FbtsIE1PEpGb%2FEFG5UVz5Kxwf8g6GAFg8Fk%2Fimg.jpg', '오전 1:34'),
      User('변우석', '선재업고튀어 >.<', [Message('요즘 너무 바빴네 ㅜㅜ', false)], 'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FcSDQIX%2FbtsIFdJaWet%2FOMg065nSQQkIS8LYi3Im81%2Fimg.jpg', '오후 5:58'),
      User('강혜윤', '마멜공주', [Message('선재업고 튀기 성공했지롱~ :)', false)], 'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbfMmBP%2FbtsIFUvrX8b%2FW1xiRrezPolPcsu3wL4blk%2Fimg.jpg', '오후 1:00'),
      User('박보검', '**원더랜드** 개봉했어요', [Message('오랜만이야!', false)], 'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FZMgI3%2FbtsIEND5FUf%2FqIjlNpM2WSP2sSnIaGDf00%2Fimg.jpg', '오후 4:23'),
      User('수지', '원더랜드 2024.06.05', [Message('드디어 영화 개봉했어! 보러 와줄꺼지?', false)], 'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FVB4SJ%2FbtsID2hqBxF%2FKxfteN2kBztkb46Nn8kF00%2Fimg.jpg', '오후 6:00'),
      User('혜인', 'NewJeans_Hyein', [Message('오늘은 내가 비눗방울 만드는 법을 알으켜줄게 ', false)], 'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FW6QrN%2FbtsIEYlc0lt%2Fw3wqAFKFlXeDqkR2IsxcXk%2Fimg.jpg', '오후 12:10'),
      User('하니', '팜하니', [Message('나 무대 잘했지!!!!!', false)], 'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FshYml%2FbtsIF1aaWRz%2FvTXIKJoBXQhqRIuuQAFac1%2Fimg.jpg', '오후 6:00'),
      User('민지', 'NewJeans_Minji', [Message('ㅋㅋㅋㅋㅋㅋ', false)], 'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FevzM5A%2FbtsIEbkYZWk%2FkvsvN6gre78SuZgM1AEmaK%2Fimg.jpg', '오전 8:00'),
    ];

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/start',
      locale: Locale('ko', 'KR'), // 한글 지원을 위한 locale 설정
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ko', 'KR'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      onGenerateRoute: (settings) {
        if (settings.name == '/chat') {
          final user = settings.arguments as User;
          return MaterialPageRoute(
            builder: (context) => ChatPage(user: user),
          );
        }
        return null;
      },
      routes: {
        '/start': (context) => const StartPage(),
        '/friend': (context) => FriendPage(users: users),
        '/chatlist': (context) => ChatListPage(users: users),
        '/grid': (context) => const GridPage(), // 추가된 부분
      },
    );
  }
}