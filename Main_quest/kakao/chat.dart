import 'package:flutter/material.dart';
import 'user.dart';

class ChatPage extends StatefulWidget {
  final User user;

  const ChatPage({required this.user, Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        widget.user.chatMessages.add(Message(_controller.text, true));
        _controller.clear();
      });
    }
  }

  void _showOptionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('옵션 선택'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text('사진촬영'),
                  onTap: () {
                    Navigator.of(context).pop();
                    // 사진촬영 로직 추가
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text('갤러리 보기'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, '/grid'); // 갤러리 보기 로직 추가
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text('인공지능에게 물어봐'),
                  onTap: () {
                    Navigator.of(context).pop();
                    // 인공지능에게 물어보기 로직 추가
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMessage(Message message) {
    return Align(
      alignment: message.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: message.isSentByMe ? Color(0xffFFFF99): Color(0xffFFCCFF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          message.text,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.name),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: widget.user.chatMessages.length,
              itemBuilder: (context, index) {
                return _buildMessage(widget.user.chatMessages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _showOptionsDialog,
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    decoration: const InputDecoration(
                      hintText: '메시지를 입력하세요...',
                    ),
                    keyboardType: TextInputType.text, // 텍스트 입력 타입 설정
                    onTap: () {
                      // 키보드가 화면에 나타나도록 설정
                      setState(() {});
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
