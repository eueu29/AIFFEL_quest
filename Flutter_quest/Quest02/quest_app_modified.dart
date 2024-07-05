import 'package:flutter/material.dart';                        //기본 패키지 불러오기

void main() => runApp(MyApp());                                //main함수로 진입점 표시, MyApp 구동


class MyApp extends StatefulWidget {               //MyApp을 StatefulWidget 상속받아 만들고 state객체 생성
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {                        //State 객체 정의
  @override
  Widget build(BuildContext context) {                         //Build함수 실행
    return MaterialApp(
        home: Scaffold(
             //앱의 상단 바
            appBar: AppBar(
              leading: Icon(Icons.catching_pokemon, size: 50), //좌측 아이콘(leading구역) 설정
              backgroundColor: Colors.blue,                    //배경색: 파란색으로 설정
              title: Center(child: Text('플러터 앱 만들기')),    //중앙정렬로 제목입력
            ),

            //본문
            body: Column(                                    //두 객체를 column에 넣어서 구성
              children: [
                Expanded(
                  flex:1, //여백이 없도록 화면전체로 구역확장
                  child: Center(                           //중앙배치
                      child: ElevatedButton(                     //ElevatedButton 객체 생성
                          child: Text("Text"),
                          onPressed: () {
                              print("버튼이 눌렸습니다. ");            //버튼을 눌렀을때 실행할 action 정의
                          },
                      ),
                )),
                Expanded(
                  flex:1,
                  child : Stack(                                      //Stack 객체 생성
                    children: [
                      Container(                              //container1,크기 300의 정사각형
//                         margin: EdgeInsets.only(bottom: 40),  //하단에서 40 pixel 띄우기
                        alignment: Alignment(0, 0),           //가운데 정렬
                        width: 300,                           //가로크기
                        height: 300,                          //세로크기
                        color: Colors.grey,
                      ),
                      Container(                             //container2. 크기 240
                        width: 240,
                        height: 240,
                        color: Colors.red,
                      ),
                      Container(                             //container3. 크기 180
                        width: 180,
                        height: 180,
                        color: Colors.purple,
                      ),
                      Container(                             //container4. 크기 120
                        width: 120,
                        height: 120,
                        color: Colors.yellow,
                      ),
                      Container(                             //container5. 크기 60
                        width: 60,
                        height: 60,
                        color: Colors.green,
                      ),
                    ],
                  )
                )
              ],
            )));
  }
}

/* stack container의 배치를 alignment(0,0)으로 했을 때, 차지하는 화면의 중앙으로 가겠다고 생각하고 사용했는데, 바닥에 붙은상태로 중앙정렬이 되어서 margin으로 강제로 공간을 생성했었다. 
   그래서 이유를 찾고자 시도해보았다.
   실험결과 Expanded를 elevation button에만 사용했었는데, 이게 stack container을 최대한 아래쪽으로 짓누른것으로 보인다. Expanded의 flex 비율을 1:1로 나누고 margin 없이 사용했을 때, 
   원하는 대로 아래공간도 띄워진, 아래공간의 정중앙에 위치한 것을 확인할 수 있었다.
