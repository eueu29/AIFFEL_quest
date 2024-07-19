import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user.dart';


class ChatListPage extends StatefulWidget {
  final List<User> users;

  ChatListPage({Key? key, required this.users}) : super(key: key);

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushNamed(context, '/friend');
    } else if (index == 1) {
      Navigator.pushNamed(context, '/chatlist');
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
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('채팅'),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                debugPrint('going to search page..');
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                debugPrint('making a new chat..');
              },
              icon: const Icon(Icons.add_comment),
            ),
            IconButton(
              onPressed: () {
                debugPrint('going to setting page');
              },
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        body: ListView.separated(
          itemCount: widget.users.length,
          itemBuilder: (context, index) {
            return Container(
              height: 100.0,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(widget.users[index].imagePath),
                ),
                title: Text(
                  widget.users[index].name,
                  style: const TextStyle(fontSize: 23),
                ),
                subtitle: Text(
                  widget.users[index].chatMessages.isNotEmpty
                    ? widget.users[index].chatMessages.last.text
                    : '',
                  style: const TextStyle(fontSize: 18, color: Color(0xff666666)),
                ),

                trailing: Text(
                  widget.users[index].time,
                  style: const TextStyle(fontSize: 12, color: Color(0xff666666)),
                ),
                onTap: () {
                  Get.toNamed('/chat', arguments: widget.users[index]);
                },
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              height: 2,
              color: Colors.grey,
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
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
          selectedItemColor: Color(0xff333333),
          unselectedItemColor: Colors.white,
          onTap: _onItemTapped,
          backgroundColor: Color.fromRGBO(153, 102, 255, 0.4),
        ),
      ),
    );
  }
}
