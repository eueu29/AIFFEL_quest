🤔 피어리뷰 템플릿  
리뷰어 : 이한나  

- [v]  **1. 주어진 문제를 해결하는 완성된 코드가 제출되었나요? (완성도)**
    - 문제에서 요구하는 최종 결과물이 첨부되었는지 확인
    - 문제를 해결하는 완성된 코드란 프로젝트 루브릭 3개 중 2개, 
    퀘스트 문제 요구조건 등을 지칭
        - 해당 조건을 만족하는 부분의 코드 및 결과물을 캡쳐하여 사진으로 첨부
          - 기본 모델과 개선 모델 모두 잘 완성해주셨습니다.
          - 기본/개선 모델 예측값 비교해주신 부분이 재밌었습니다.  
            기본 모델   
            ![image](https://github.com/user-attachments/assets/de3c42fd-ca44-4d23-8953-896f732df3a8)  
            개선 모델    
            ![image](https://github.com/user-attachments/assets/b28eed88-4728-4024-9a66-50a5f712dec0)  
  
  
- [v]  **2. 프로젝트에서 핵심적인 부분에 대한 설명이 주석(닥스트링) 및 마크다운 형태로 잘 기록되어있나요? (설명)**
    - [v ]  모델 선정 이유
    - [v]  하이퍼 파라미터 선정 이유
    - [v]  데이터 전처리 이유 또는 방법 설명

                  # 데이터 전처리( 구두점 제거)
                  # 전처리 함수
                  def preprocess_sentence(sentence):
                      # 입력받은 sentence양쪽 공백을 제거
                      sentence = sentence.strip()
                      
                      # 단어와 구두점(punctuation) 사이의 거리를 만듭니다.
                      # 예를 들어서 "I am a student." => "I am a student ."와 같이
                      # student와 특수문자 사이에 거리를 만듭니다.
                      sentence = re.sub(r"([?.!,])", r" \1 ", sentence)  # ?.!, 앞 뒤로 공백 추가
                      sentence = re.sub(r'[" "]+', " ", sentence)  # 하나이상의 연속된 공백을 단일 공백문자로 대체
                      
                      #영어와 한글, [.,?!]을 제외한 모든 문자 지우기
                      sentence = re.sub(r"[^가-힣a-zA-Z.,?!]", " ", sentence)
                      sentence = sentence.strip()
                      return sentence
      
- [v]  **3. 체크리스트에 해당하는 항목들을 수행하였나요? (문제 해결)**
    - [ ]  데이터를 분할하여 프로젝트를 진행했나요? (train, validation, test 데이터로 구분)
    - [V ]  하이퍼파라미터를 변경해가며 여러 시도를 했나요? (learning rate, dropout rate, unit, batch size, epoch 등)
    - [ ]  각 실험을 시각화하여 비교하였나요?
    - [V ]  모든 실험 결과가 기록되었나요?  
            기본모델 개선모델 모두 EPOCHS = 50 으로 잘 학습되었고 결과도 잘 나왔습니다.  
            각 모델 별 결과값이 달라 흥미롭습니다.    
         
- [v]  **4. 프로젝트에 대한 회고가 상세히 기록 되어 있나요? (회고, 정리)**
    - [ V]  배운 점
    - [V ]  아쉬운 점
    - [V ]  느낀 점
    - [V ]  어려웠던 점  
            - transformer 모델 결과값 accuracy에 대한 설명이 몰랐던 부분이었는데,  
              이번 기회 알 수 있어 흥미로웠습니다.    
              감사합니다!    

- [ ]  **5.  앱으로 구현하였나요?**
    - [ ]  구현된 앱이 잘 동작한다.
    - [ ]  모델이 잘 동작한다.
