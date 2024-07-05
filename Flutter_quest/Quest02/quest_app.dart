{
  "nbformat": 4,
  "nbformat_minor": 0,
  "metadata": {
    "colab": {
      "provenance": []
    },
    "kernelspec": {
      "name": "python3",
      "display_name": "Python 3"
    },
    "language_info": {
      "name": "python"
    }
  },
  "cells": [
    {
      "cell_type": "code",
      "execution_count": null,
      "metadata": {
        "id": "0BvxgPi7iPjP"
      },
      "outputs": [],
      "source": [
        "import 'package:flutter/material.dart';                        //기본 패키지 불러오기\n",
        "\n",
        "void main() => runApp(MyApp());                                //main함수로 진입점 표시, MyApp 구동\n",
        "\n",
        "\n",
        "class MyApp extends StatefulWidget {               //MyApp을 StatefulWidget 상속받아 만들고 state객체 생성\n",
        "  MyAppState createState() => MyAppState();\n",
        "}\n",
        "\n",
        "class MyAppState extends State<MyApp> {                        //State 객체 정의\n",
        "  @override\n",
        "  Widget build(BuildContext context) {                         //Build함수 실행\n",
        "    return MaterialApp(\n",
        "        home: Scaffold(\n",
        "             //앱의 상단 바\n",
        "            appBar: AppBar(\n",
        "              leading: Icon(Icons.catching_pokemon, size: 50), //좌측 아이콘(leading구역) 설정\n",
        "              backgroundColor: Colors.blue,                    //배경색: 파란색으로 설정\n",
        "              title: Center(child: Text('플러터 앱 만들기')),    //중앙정렬로 제목입력\n",
        "            ),\n",
        "\n",
        "            //본문\n",
        "            body: Column(                                    //두 객체를 column에 넣어서 구성\n",
        "              children: [\n",
        "                Expanded(                                    //여백이 없도록 화면전체로 구역확장\n",
        "                    child: Center(                           //중앙배치\n",
        "                        child: ElevatedButton(                     //ElevatedButton 객체 생성\n",
        "                            child: Text(\"Text\"),\n",
        "                            onPressed: () {\n",
        "                                print(\"버튼이 눌렸습니다. \");            //버튼을 눌렀을때 실행할 action 정의\n",
        "                    },\n",
        "                  ),\n",
        "                )),\n",
        "                Stack(                                      //Stack 객체 생성\n",
        "                  children: [\n",
        "                    Container(                              //container1,크기 300의 정사각형\n",
        "                      margin: EdgeInsets.only(bottom: 40),  //하단에서 40 pixel 띄우기\n",
        "                      alignment: Alignment(0, 0),           //가운데 정렬\n",
        "                      width: 300,                           //가로크기\n",
        "                      height: 300,                          //세로크기\n",
        "                      color: Colors.grey,\n",
        "                    ),\n",
        "                    Container(                             //container2. 크기 240\n",
        "                      width: 240,\n",
        "                      height: 240,\n",
        "                      color: Colors.red,\n",
        "                    ),\n",
        "                    Container(                             //container3. 크기 180\n",
        "                      width: 180,\n",
        "                      height: 180,\n",
        "                      color: Colors.purple,\n",
        "                    ),\n",
        "                    Container(                             //container4. 크기 120\n",
        "                      width: 120,\n",
        "                      height: 120,\n",
        "                      color: Colors.yellow,\n",
        "                    ),\n",
        "                    Container(                             //container5. 크기 60\n",
        "                      width: 60,\n",
        "                      height: 60,\n",
        "                      color: Colors.green,\n",
        "                    ),\n",
        "                  ],\n",
        "                )\n",
        "              ],\n",
        "            )));\n",
        "  }\n",
        "}\n",
        "\n",
        "'''\n",
        " 회고\n",
        "\n",
        " 임상운: 일단 책의 내용들을 활용 할 수 있어서 좋았고 난이도가 너무 높지 않아서 좋았다. 유진님과 번갈아 가면서 작성을 잘 하였고 주석도 유진님이 잘\n",
        " 달아 주셨다. 아쉬웠던점은 시간이 많이 남았다는 것이다. 훗... ㅋㅋ 하지만 빠르게 완성 할 수 있어서 여유로운 마음으로 회고도 작성하고 좋았다.\n",
        " 퀘스트들이 이번만 같아 줬으면 좋겠다는 생각이 들었다. ㅎㅎ\n",
        "\n",
        " 이유진: 책의 내용을 다 기억은 못하더라도 어디에 있었지! 정도는 파악할 수 있어져서 책을 뒤적거리면서 이렇게 하면 될것같아요!를 상운님과 번갈아가면서 반복하다보니 코드가 금새 완성되었다.\n",
        " 팀워크가 매우 좋았던 느낌적인 느낌?! 그리고 오히려 틀이 정해져있는 코드를 가져다가 잘 이어붙이면 돼서 지난번 Dart 언어 퀘스트보다 더 수월했던 것 같다.\n",
        " 진짜 뭐라도 만들 수 있다! 에 한발짝 더 다가간 느낌이다.\n",
        " 상운님이 알려주신 Expanded 개념이 너무 유용해서 한번 다시 공부해봐야겠다.\n",
        "\n",
        "'''"
      ]
    }
  ]
}