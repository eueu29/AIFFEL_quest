# 팀소개<br>
DLthon : HOTDOG팀<br>
팀장 : 이유진<br>
팀원 : 강대식, 박진석, 정권영<br>
<br>
## 앱 정보 <br>
강아지, 고양이 이미지를 입력 시,  
해당 동물의 종을 분류하고,  
챗봇 API 연결을 통해 해당 종에 대한 데이터를 얻고,  
애완동물의 얼굴을 인식해 해당되는 이미지(선글라스, 귀걸이, 모자 등)를 합성해주는 갤러리 어플  

## 모델 설정<br>
classification : Xception<br>
bounding box detection : YOLOv8n<br>
landmark detection : dlib모듈
 <br> <br>  
## 회고  
##### 박진석 :  
- **신중한 데이터 전처리 필요**  데이터를 어떻게 전처리하느냐에 따라 정확도/검증 정확도가 15%이상 차이가 났다.  
- 훈련된 모델을 미세조정하여 사용할 때 학습률을 낮춰서 여러가지 모델을 사용하여 그 중 가장나은 모델을 선정하여 일부 동결해제, 데이터 증강등으로 개선 시키는 순서로 진행  
- 작은 데이터 셋이라고 해서 데이터 증강이 필수가 아님 모델에 따라서 데이터셋 양 고려. 몇 모델에서 데이터 증강을 했을 때 오히려 검증정확도가 떨어지는 경우가 있었다. 
- skip connection 정확한 개념을 알고 사용필요  
- 성능 개선중 동결해제한 층으로 skip connection을 했을 때(vgg16) 성능이 떨어지는 경우가 있었다  
- **팀내 다른 그룹의 작업에 어느정도의 이해필요** 다른 그룹에서 문제 해결 요구한 것이 모델에 관련되었다고 생각했는데 코드 메커니즘 문제였음. 해결에 효율적으로 시간을 사용하지 못함
---
##### 정권영:
- 이미지 파일명에서 특수기호, 확장자등을 제거하고 리스트화 시키는데는 문제가 없었다.
- 해당 이미지를 모델에 적용시키는 문제, 서버로 전송하는데 문제가 있었다.
- DB를 사용하여 이미지를 저장하는게 아니고, 파일시스템(캐시)에 저장되고 URL이미지로 서버 <-> 클라이언트 주고받는데 문제가 있었다.
- 또한 이미지 업로드는 로컬 또는 휴대폰에 있는 이미지를 업로드 하는 방법이기에 이또한 문제가 있었다.
- 카메라도 마찬가지로 휴대폰으로 촬영을 하고 촬영된 이미지를 저장하는데 문제가 있었는데 DB를 사용안하다 보니 파일시스템으로 이미지를 저장하였다.
- 위 경우 파일시스템은 APP을 종료하거나 서버를 종료할시에는 없어지는 데이터이고 일반적으로는 접근이 어려웠다.
- NGROK을 통해 서버와 클라이언트가 데이터를 주고받는데 이또한 고정 URL이 아니라 서버를 종료하거나 APP을 종료할시 바뀌는 주소이다. 매번 새로 주소루트를 바꿔줘야 한다.
---
##### 이유진:
---
<br>
## 참고 학습자료  
- https://blog.naver.com/dnjswns2280/221918816575  
- https://github.com/kairess/dog_face_detector
- https://github.com/kairess/cat_hipsterizer
- https://suy379.tistory.com/92
- https://blog.naver.com/tommybee/222752809075
- https://docs.ultralytics.com/modes/train/#apple-m1-and-m2-mps-training
- https://blog.naver.com/whitegreen_/223432155198
- https://humansintheloop.org/10-of-the-best-open-source-annotation-tools-for-computer-vision/?utm_term=&utm_campaign=Humans+in+the+Loop+Brand+Campaign&utm_source=adwords&utm_medium=ppc&hsa_acc=7694807070&hsa_cam=17031828146&hsa_grp=139977411321&hsa_ad=596553673906&hsa_src=g&hsa_tgt=dsa-19959388920&hsa_kw=&hsa_mt=&hsa_net=adwords&hsa_ver=3&gad_source=1&gclid=Cj0KCQjwzby1BhCQARIsAJ_0t5MvFhbJOs96xxrcZrxR8u4PiQTgtEnyA6aBSxXQ32oXkjFs62VIzAwaAhW8EALw_wcB
- https://www.kaggle.com/datasets/georgemartvel/catflw/data






