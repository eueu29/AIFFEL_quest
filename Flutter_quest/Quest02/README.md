**PRT(Peer Review Template)**

코더: 이유진
리뷰어: 김재이

- [O]  **1. 주어진 문제를 해결하는 완성된 코드가 제출되었나요?**
    - 문제에서 요구하는 기능이 정상적으로 작동합니다. 결과물 사진도 깃허브에서 함께 볼 수 있습니다.
```
```
    
- [O]  **2. 핵심적이거나 복잡하고 이해하기 어려운 부분에 작성된 설명을 보고 해당 코드가 잘 이해되었나요?**
    - 주석을 매우 상세하게 달아주셨습니다. 작동 매커니즘도 물론 잘 알 수 있었고, 눈으로는 헤매기 쉬운 전체적인 구조도 주석으로 인해 잘 파악할 수 있었습니다.
```
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
                Expanded(                                    //여백이 없도록 화면전체로 구역확장
                    child: Center(                           //중앙배치
                        child: ElevatedButton(                     //ElevatedButton 객체 생성
...
```
                
- [O]  **3.** 에러가 난 부분을 디버깅하여 “문제를 해결한 기록”을 남겼나요? 또는
   “새로운 시도 및 추가 실험”을 해봤나요? ****
    - 배운 내용을 기록해주셨고, 그 안에서 시도하신 내용들을 알 수 있었습니다.
```
   주로 나는 에러 : 기존 Row, Column등 자식들이 화면 사이즈를 넘겼거나, 남는 공간이 없을 경우 & 반드시 stateful 또는 statelesswidget을 가져야하며 RenderObjectWidget은 가질 수 없다
```
        
- [O]  **4. 회고를 잘 작성했나요?**
    - 프로젝트 결과물에 대해 배운점이 잘 기재되어 있습니다. 프로젝트 과정도 생생하게 알 수 있었습니다.
```
/* Expanded : Row, column, Flex이 자식위젯으로 사용 가능함.
   부모이 남는 부분은 전부 채우는 식으로 화면에 나타난다. 
   Expanded가 하나라면 나머지 칸을 전부 채우고, 여러개라면 1/n크기,
...
```
```
책의 내용을 다 기억은 못하더라도 어디에 있었지! 정도는 파악할 수 있어져서 책을 뒤적거리면서 이렇게 하면 될것같아요!를 상운님과 번갈아가면서 반복하다보니 코드가 금새 완성되었다.
 팀워크가 매우 좋았던 느낌적인 느낌?! 그리고 오히려 틀이 정해져있는 코드를 가져다가 잘 이어붙이면 돼서 지난번 Dart 언어 퀘스트보다 더 수월했던 것 같다.
 진짜 뭐라도 만들 수 있다! 에 한발짝 더 다가간 느낌이다.
 상운님이 알려주신 Expanded 개념이 너무 유용해서 한번 다시 공부해봐야겠다.
```

- [O]  **5. 코드가 간결하고 효율적인가요?**
    - 효율적입니다. 코드 중복은 거의 없었고, 실제로 버튼 구현만하면 사용가능하도록 Stateful 위젯으로 코딩해주셨습니다.
      개인적으로는 이번 퀘스트만을 위해서 Stateless위젯으로 구현했는데, 실제 기능을 떠올려보면 Stateful을 사용하는 것이 더 알맞기에 흥미로웠습니다!
```
class MyApp extends StatefulWidget {               //MyApp을 StatefulWidget 상속받아 만들고 state객체 생성
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {                        //State 객체 정의
  @override
  Widget build(BuildContext context) {                         //Build함수 실행
    return MaterialApp(
        home: Scaffold(
...
```
