import 'package:flutter/material.dart'; 
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MyApp());      //main함수로 진입점 표시, MyApp 구동
             
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute : '/cat',                // 초기화면 
      routes : {
        '/cat' : (context) => CatPage(),
        '/dog' : (context) => DogPage()
      }
    );
  }
}

class CatPage extends StatelessWidget {   

  @override
  Widget build(BuildContext context) {                         //Build함수 실행
    return MaterialApp(
        home: Scaffold(
             //앱의 상단 바
            appBar: AppBar(
              leading: Container(
                margin : EdgeInsets.all(10.0), 
                child : FaIcon(FontAwesomeIcons.cat, size: 40, color: Color(0xffFF6666)),   //고양이 이모티콘 삽입
               ), 
              backgroundColor: Color(0xffCCFFCC),        //배경색 입력
              title: Center(child: Text('First Page')),    //중앙정렬로 제목입력
            ),

            //본문
            body: Column(                                    //button, image 두 객체를 column에 넣어서 구성
              children: [
                Expanded(                                    //Expanded, flex:1 을 button에 설정해주어 화면배치
                  flex:1, 
                  child: Center(                             //중앙배치
                      child: ElevatedButton(                 //ElevatedButton 객체 생성
                          child: Text("Next", style : TextStyle(fontSize: 30)),
                          onPressed: () async {
                            bool isCat = true;               //isCat 변수 생성
                            print('isCat = $isCat');  
                            isCat = false;                   //isCat 변수 false값으로 초기화
                            final result = await Navigator.pushNamed(context, '/dog', arguments: false);  //버튼을 눌렀을 때, dogpage로 넘어가도록 Navigator기능 사용. pushNamed를 통해 넘어갈 때 false값을 전달함
                            isCat = result as bool;   //dogpage에서 page를 pop할 때 전달한 값을 result로 전달받고, 해당 값을 isCat에 재할당함     
                          },
                      ),
                )),
                Expanded(                                    //Expanded, flex:1 을 image에도 설정해주어 화면배치
                  flex:1,
                  child : Column(children: [Image.asset('images/kitten.jpg')],)
                )
              ],
            )
        )
    );
  }
}

//dogpage에서도 cat page에서 한 것과 구성은 동일함
class DogPage extends StatelessWidget { 

  @override
  Widget build(BuildContext context) {      
    bool arg = ModalRoute.of(context)?.settings.arguments as bool;          //cat page에서 pushNamed를 통해 전달한 값을 ModalRoute.of를 통해 넘겨받음 
    return MaterialApp(
        home: Scaffold(
             //앱의 상단 바
            appBar: AppBar(
              leading: Container(
                margin : EdgeInsets.all(10.0), 
                child : FaIcon(FontAwesomeIcons.dog, size: 40, color: Color(0xff33FFFF)), 
               ), //좌측 아이콘(leading구역) 설정
              backgroundColor: Color(0xffFFFF99),           
              title: Center(child: Text('Second Page')),    
            ),

            //본문
            body: Column(                                    
              children: [
                Expanded(
                  flex:1, 
                  child: Center(                         
                      child: ElevatedButton(                  
                          child: Text("Back", style : TextStyle(fontSize: 30)),
                          onPressed: () {
                            print('isCat = $arg');          // catpage에서 pushnamed를 통해 넘겨받은 값 출력
                            Navigator.pop(context, true);   // button을 눌렀을 때 page가 pop되면서 stack에서 삭제됨. 동시에 true값을 pushnamed에 전달함
                          },       
                      ),
                )),
                Expanded(
                  flex:1,
                  child : Column(children: [Image.asset('images/puppy.jpg')],)
                )
              ],
            )
        )
    );
  }
}

/* 회고
정권영 : 
플러트를 사용하는 두번째 퀘스트인데 기초가 부족하다고 많이 느끼게 되는 퀘스트였습니다.
요번 퀘스트를 진행하면서 페이지관리는 어떻게 할까?, 데이터 전달은 어떻게 하지? 이미지는 어떻게 넣지?, 아이콘은 어떻게 넣지?? 많은 고민이 들게된 퀘스트였습니다.
좀더 학습이 필요하다고 느낍니다. 분발하겠습니다.

이유진:
지금까지 학습한 것을 notion에 차곡차곡 정리했었는데, 덕분에 쉽게 찾아보면서 퀘스트를 할 수 있었던 것 같아 셀프칭찬을 잠시 해주었습니다.
그리고 미션 중 값을 전달하는 과정이 생각보다 쉽지 않았는데 isCat = result로 값을 재할당하는 방법으로 해결할 수 있었습니다. 
페이지를 넘겨주고, 값을 전달하는 과정에 대해 다시 한번 익힐 수 있어 좋았습니다.
권영님의 엄청난 색감 센스 덕분에 appbar의 background와 icon의 색상을 이쁘게 꾸밀 수 있어 매우 만족했습니다 :)
*/
