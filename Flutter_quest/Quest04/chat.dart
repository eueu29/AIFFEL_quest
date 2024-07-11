// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'user.dart';

class ChatPage extends StatefulWidget {
  final List<User> users;

  ChatPage({Key? key, required this.users}) : super(key: key);

  ChatState createState() => ChatState();
}

class ChatState extends State<ChatPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushNamed(context, '/friend');
    } else if (index == 1) {
      Navigator.pushNamed(context, '/chat');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(153, 102, 255, 0.2),
          foregroundColor: Color(0xff666666),
        )),
        home: Scaffold(
            appBar: AppBar(
              title: const Text('채팅'),
              actions: <Widget>[
                IconButton(
                    onPressed: () {
                      debugPrint('going to search page..');
                    },
                    icon: const Icon(Icons.search)),
                IconButton(
                    onPressed: () {
                      debugPrint('making a new chat..');
                    },
                    icon: const Icon(Icons.add_comment)),
                IconButton(
                    onPressed: () {
                      debugPrint('going to setting page');
                    },
                    icon: const Icon(Icons.settings)),
              ],
            ),
            body: ListView.separated(
              itemCount: widget.users.length,
              itemBuilder: (context, index) {
                return Container(
                    height: 100.0,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            widget.users[index].imagePath != null &&
                                    widget.users[index].imagePath!.isNotEmpty
                                ? AssetImage(widget.users[index].imagePath!)
                                : null,
                      ),
                      title: Text(
                        widget.users[index].name,
                        style: const TextStyle(fontSize: 23),
                      ),
                      subtitle: Text(
                        widget.users[index].chat,
                        style: const TextStyle(
                            fontSize: 18, color: Color(0xff666666)),
                      ),
                      trailing: Text(
                        widget.users[index].time,
                        style: const TextStyle(
                            fontSize: 12, color: Color(0xff666666)),
                      ),
                      onTap: () {
                        debugPrint(widget.users[index].name);
                      },
                    ));
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 2,
                  color: Colors.grey,
                );
              },
            ),
            bottomNavigationBar: Container(
                height: 80, // 원하는 높이 설정
                child: BottomNavigationBar(
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.diversity_1),
                        label: '친구',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.message),
                        label: '채팅',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.forum),
                        label: '오픈채팅',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.shopping_basket),
                        label: '쇼핑',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.more_horiz),
                        label: '더보기',
                      ),
                    ],
                    type: BottomNavigationBarType.fixed,
                    currentIndex: _selectedIndex,
                    selectedItemColor:
                        Color(0xff333333), // 버튼 선택 시 버튼에 해당 색상이 적용됨
                    unselectedItemColor: Colors.white, // 선택되지 않은 항목의 색상 설정
                    onTap: _onItemTapped,
                    backgroundColor: Color.fromRGBO(153, 102, 255, 0.4)))));
  }
}
