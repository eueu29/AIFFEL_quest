from google.cloud import aiplatform
from google.oauth2 import service_account
from vertexai.preview.vision_models import ImageCaptioningModel, Image

class VertexAIModel:
    def __init__(self, project_id, location):
        # 서비스 계정 JSON 파일 경로
        credentials_path = "C:/Study/avian-axis-431702-k7-d9a9ddcd1749.json"
        credentials = service_account.Credentials.from_service_account_file(credentials_path)
        
        # 프로젝트와 위치 초기화
        aiplatform.init(project=project_id, location=location, credentials=credentials)
        self.image_captioning_model = ImageCaptioningModel.from_pretrained("imagetext@001")

    def generate_captions(self, image_path, num_results=3, language="en"):
        try:
            # 이미지 로드
            cloud_image = Image.load_from_file(image_path)
            # 캡션 생성
            captions = self.image_captioning_model.get_captions(
                image=cloud_image, 
                number_of_results=num_results, 
                language=language
            )
            return captions
        except Exception as e:
            # 오류 처리
            print(f"Error generating captions: {e}")
            return None