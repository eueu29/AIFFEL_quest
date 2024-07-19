# 카카오톡 앱 분석 및 역설계하기

## 앱 정보 
- 앱 이름 : 카카오톡<br><br>
 <br> <br>
## 앱 구조도    <br>
![Untitled (1)](https://github.com/user-attachments/assets/92038be4-3d64-42e7-9c0a-3cb6ff8e71e2) 
![Untitled](https://github.com/user-attachments/assets/f1866ad7-52e6-4fa3-b515-744c396a89b6)
 <br> <br>
## 앱 와이어프레임(사용툴 : 파워포인트) <br>
![스크린샷 2024-07-19 15-47-48](https://github.com/user-attachments/assets/98014813-69c5-4e1b-b6d4-bf72df043439)
 <br> <br>
## 프로토타이핑 구현  
![스크린캐스트 2024년 07월 19일 16시 19분 23초](https://github.com/user-attachments/assets/e0f5ec95-c400-4ade-86d0-3b4da2bd1be8)
 <br> <br>  
## 구현영상
![스크린캐스트 2024년 07월 19일 15시 52분 48초](https://github.com/user-attachments/assets/f2999b47-da5f-4f47-9844-2ff1cbde0316)


 <br> <br>  
## 참고 학습자료  
github에 동영상 삽입방법 참고함 : https://ndb796.tistory.com/557 <br>
지하철 : <br>
https://data.seoul.go.kr/dataList/OA-15799/A/1/datasetView.do <br>
https://www.data.go.kr/data/15125683/openapi.do <br>
https://smss.seoulmetro.co.kr/traininfo/traininfoUserView.do <br>
https://www.data.go.kr/tcs/dss/selectApiDataDetailView.do?publicDataPk=15000414#/tab_layer_detail_function <br>
Gemini : <br>
https://colab.research.google.com/drive/1jJK9lDVJ3IYDWdVgUEa2nUFzyZ09rUH8#scrollTo=6SluJi0dFcIY <br>
https://ai.google.dev/gemini-api/docs/get-started/tutorial?hl=ko&_gl=1*1awq7o6*_up*MQ..*_ga*MjE5NzQzNTI3LjE3MjEzNjgxNzM.*_ga_P1DBVKWT6V*MTcyMTM2ODE3Mi4xLjAuMTcyMTM2ODE3Mi4wLjAuMTk5NDM0NDEx&lang=python#generate-text-from-text-and-image-input <br>
ChatGPT <br>
<br>
## 회고  
제미나이나 segmantation을 구현하고 싶었으나 시간이 잘 진행되지는 못했다... <br>
안되면 vgg16이라도 구현하고 싶었으나 시간이 부족한데 자꾸 tensorflow와 서버 등 에러가 자꾸 터져서 진행하지 못헀다... <br>
원래 지하철 알림앱을 만들고 싶었으나 api파일을 가져와 정보를 정리해서 두번째 api 파일에 넣는 과정까지 필요했어서 그걸 구현하는데 퀘스트 첫날을 다 소비했으나...<br>
결국 가지고 있는 자료만으로는 구현할 수 없다는 사실을 꺠닫고 지난번에 구현했던 프로젝트틀을 이어붙이는 식으로밖에 시간이 남지 않아서 아쉽다.<br>
dart언어와 flutter가 아직도 스스로의 힘으로 다 구현하기에는 많이 부족하여 chatGPT의 힘을 많이 빌릴 수 밖에 없었다.<br>
그치만 데이터를 저장하여 줄력하는 기능까지는 구현해 볼 수 있게 되었다. 책에서는 뒤에 데이터를 관리하는(계속 저장하는)부분까지 있었는데 해당 부분까지 습득하고 계속 저장될 수 있도록 구현까지 했으면 더 좋았을 것 같다.<br>
많이 배웠고, 많이 부족한 점을 깨달은 메인퀘스트였던 것 같다.<br>
그치만 몇주만에 앱 모양정도는 그럭저럭 꾸밀 수 있게 되었다는 점에 의의를 두는것으로..<br>





