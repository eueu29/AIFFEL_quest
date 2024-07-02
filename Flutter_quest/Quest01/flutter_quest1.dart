// timer기능을 위한 패키지 불러오기 
// ignore_for_file: avoid_print(print가 에러메세지 계속 떠서 삭제하기 위한 코드), avoid_print

import 'dart:async';

// 타이머 함수 생성
void startTimer(){
  print('Pomodoro 타이머를 시작합니다. 25분동안 집중해주세요.');
  int count = 1;                 //사이클 count
  int workTime = 1500;              //기본 작업시간(25분)
  int restTime = 300;              //기본 휴식시간(5분)     

/// Timer.periodic : 이 함수는 지정된 콜백 함수를 일정한 간격으로 반복 실행하는 새로운 타이머를 생성합니다.
/// const Duration(seconds: 1): 1초를 나타내는 Duration 객체를 생성합니다. const 키워드는 컴파일 타임 상수를 생성하여 성능을 최적화하는 데 도움이 됩니다.
/// (timer): 익명 함수(람다 또는 클로저)로, timer라는 하나의 매개변수를 받습니다.timer 매개변수는 이 콜백을 트리거한 타이머를 나타내는 Timer 타입입니다.

  Timer.periodic(const Duration(seconds: 1), (timer) {  // Timer.periodic 호출
    if (workTime != 0){          //작업시간이 0이 될때까지 timer 측정      
      workTime--;                //작업시간에서 -1초씩 빼기
      print('작업시간: ${secondFormat(workTime)}');
      
      if (workTime == 0){
        print('작업시간이 종료되었습니다. ${count %4 == 0? 15:5}분동안 휴식을 취해주세요.'); //count를 4로 나눈 몫이 0인가?의 질문에서 True이면 15가 출력되고, false면 5가 출력됨
      }
    //작업시간 = 0 으로 총료됨, 휴식시간 시작
    } else if (restTime != 0){   //휴식시간이 0이 될때까지 timer 측정
      restTime--;                //휴식시간에서 -1초씩 빼기
      print('휴식시간 ${secondFormat(restTime)}');

    // 휴식시간 = 0으로 총료됨. 한사이클 종료
    } else{
      print('$count 사이클 종료');

      count++;                  // count +1 
      if (count % 4 == 0) {     // 4사이클 마다 휴식시간 15분으로 연장
        workTime = 1500;           // workTime 25분으로 리셋
        restTime = 900;           // restTime 15분으로 설정     
      } else {
        workTime = 1500;           // workTime 25분으로 리셋
        restTime = 300;           // restTime 5분으로 리셋
      }
    }
  });
}

  // // 분,초 시각화 처리하기(ver1. 00:00)
  // String secondFormat(int second){
  //   var duration = Duration(seconds: second);
  //   var duration_min = duration.toString().split('.').first.substring(2);
  //   return duration_min;

  ///코드설명 보충
  /// secondFormat : 인간이 읽기 쉬운 형식으로 시간객체를 변환하는 함수
  /// Duration : 주어진 초(second)를 기반으로 duration 객체를 생성함
  /// .toString() : duration 객체를 문자열로 반환(결과 : HH:MM:SS.mmmmm)
  /// .split('.').first : 반환된 duration객체에서 microsecond 부분은 버리고 HH:MM:SS 부분만 남기기
  /// .substring(2) : 문자열의 첫 두 문자를 제거함
  /// .replaceAll(':','분') : 문자열의 모든 ':'을 '분'으로 대체함

  // 분,초 시각화 처리하기(ver2. 00분00초)
  String secondFormat(int second){
    var duration = Duration(seconds: second);
    var duration_min = duration.toString().split('.').first.substring(2).replaceAll(':', '분');
    return ('$duration_min초');
  }

void main(){                    // 프로그램 실행을 위한 main 함수 호출 
  startTimer();                 // 포모도로 타이머 실행     
}

/// 회고
/// 선웅님과 처음으로 퀘스트를 같이 진행했다. 
/// 다트 언어에 대해 아직 숙지를 완전히 하지 못했다고 느껴 자신이 없는 상태였는데, 
/// 모르는 부분은 여쭤보면 하나하나 다 친절히 알려주셔서 많이 배우는 퀘스트였다. 
/// 분, 초를 이쁘게 시각화해서 보는 작업도 두가지 버전이나 시도해봤는데 만족스럽게 나온것 같다 
/// '이렇게 해볼까요?'하면 바로 코드가 출력되는 선웅님께 무한감사를 보낸다 :)
/// 퀘스트를 진행하면서 다트언어가 조금은 더 익숙해진 부분이 있는 것 같고,  
/// 파이썬보다 간단하게 작성되는 부분들(ex. ${count %4 == 0? 15:5})도 있고, 비슷한 부분들도 있어서 비교하면서 배우는 재미가 있었다.
/// 더 많은 연습과, 추가학습의 필요성을 절실히 꺠달았다...ㅎㅎ 