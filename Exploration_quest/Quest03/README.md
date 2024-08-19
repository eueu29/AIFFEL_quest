# 회고  
## 김주현  
- 노드 학습에서 활용되었던 DeepLabV3+ 모델 이후에 segmentation 작업을 위해 개발된 여러 모델들의 발전 과정에 대해 간략하게나마 정리할 수 있는 시간이었음. (특히, Transformer 기반으로 개발된 ViT 모델, Swin Transformer 모델, Mask2Former 모델 등에 대해 관심이 생기는 계기가 되었음)  
- 특히, 최근에는 이미지와 텍스트를 동시에 처리할 수 있도록 사전 학습된 거대 Vision-Language 모델(예: CLIP)을 활용하여 새로운 카테고리의 객체라 하더라도 별도의 학습 없이 Segmentation 작업을 처리할 수 있는 zero-shot segmentation 뱡향으로 기술이 발전해 가고 있음을 이해할 수 있었음.  
- 또한 CLIP 기반으로 segmentation 작업에 특화된 모델로 개발된 CLIPSeg 모델을 직접 로드해 추론 과정에 사용해 보면서, Pytorch 기반으로만 개발된 허깅페이스 모델을 활용하는 경험도 가질 수 있었음.  
- 추가로 Meta에서 개발된 SAM(Segment Anything Model) 모델도 추론 과정에 직접 사용해보고 싶었으나, GPU가 없는 환경에서는 여러 에러가 발생해 사용하지 못한 점이 아쉬움으로 남음.

## 이유진  
- DeepLab 모델이 최신 tensorflow 사양에서는 돌아가지 않다 조금 당황하였으나, pytorch로 실행시킬 수 있는 방안이 있다는 것을 알게되어 이 기회에 pytorch도 설치해서 사용해보는 계기가 되었음.
- 처음 써보는 pytorch이다보니, torchvision이 설치되지 않는 등의 어려움이 있었다.
- 최신 기법인 transformer modeldls SAM, CLIP모델도 돌려보았는데, 모델 자체가 무겁다보니 local의 사양으로는 돌아가지 않았고, colab에서만 GPU를 사용하여 돌아가서 local에서는 구현하지 못한점이 아쉽다
