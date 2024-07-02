// timer기능을 위한 패키지 불러오기 
// ignore_for_file: avoid_print

import 'dart:async';

// 타이머 함수 생성
void startTimer(){
  print('Pomodoro 타이머를 시작합니다. 25분동안 집중해주세요.');
  int count = 1;                 //사이클 count
  int workTime = 5;              //기본 작업시간(25분)
  int restTime = 3;              //기본 휴식시간(5분)     

  Timer.periodic(const Duration(seconds: 1), (timer) {  // Timer.periodic 호출
    if (workTime != 0){          //작업시간이 0이 될때까지 timer 측정      
      workTime--;                //작업시간에서 -1초씩 빼기
      print('작업시간: ${secondFormat(workTime)}');
      
      if (workTime == 0){
        print('작업시간이 종료되었습니다. ${count %4 == 0? 15:5}분동안 휴식을 취해주세요.');
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
        workTime = 5;           // workTime 25분으로 리셋
        restTime = 9;           // restTime 15분으로 설정     
      } else{
        workTime = 5;           // workTime 25분으로 리셋
        restTime = 3;           // restTime 5분으로 리셋
      }
    }
  });
}

  // // 분,초 시각화 처리하기(ver1. 00:00)
  // String secondFormat(int second){
  //   var duration = Duration(seconds: second);
  //   var duration_min = duration.toString().split('.').first.substring(2);
  //   return duration_min;

  // 분,초 시각화 처리하기(ver2. 00분00초)
  String secondFormat(int second){
    var duration = Duration(seconds: second);
    var duration_min = duration.toString().split('.').first.substring(2).replaceAll(':', '분');
    return ('$duration_min초');
  }

void main(){                    // 프로그램 실행을 위한 main 함수 호출 
  startTimer();                 // 포모도로 타이머 실행     
}