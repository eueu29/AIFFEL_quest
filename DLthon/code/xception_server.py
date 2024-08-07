import uvicorn
from fastapi import FastAPI, HTTPException, UploadFile, File
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse, StreamingResponse
import xception_prediction_model
import google.generativeai as genai
import logging
import os
import io
import random
from fastapi.staticfiles import StaticFiles
from fastapi.exceptions import RequestValidationError
import cv2
import numpy as np
from vertexai_model import VertexAIModel
from googletrans import Translator
import dlib
from keras.models import load_model
from keras.optimizers import Adam
import bbsmodel
from ultralytics import YOLO
import tensorflow as tf

# 번역 함수
def translate_to_korean(text):
    translator = Translator()
    translation = translator.translate(text, dest='ko')
    return translation.text

# TensorFlow의 특정 최적화 기능 비활성화
os.environ['TF_ENABLE_ONEDNN_OPTS'] = '0'

# FastAPI 애플리케이션 생성
app = FastAPI()

# Vertex AI 모델 초기화
vertexai_model = VertexAIModel(project_id="avian-axis-431702-k7", location="us-central1")

# CORS 설정
origins = ["*"]
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 로깅 설정
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# 모델을 한 번만 로드합니다.
try:
    model = xception_prediction_model.load_model_custom()
    logger.info("Model loaded successfully")
except Exception as e:
    logger.error("Failed to load model: %s", e)
    raise

# API 키를 직접 설정
api_key = 'YOUR_GOOGLE_API_KEY'  # 실제 API 키로 변경하세요
if not api_key:
    raise ValueError('No GOOGLE_API_KEY found')

# Generative AI 모델 설정
genai.configure(api_key=api_key)

# YOLO 모델 로드
BBS_MODEL_PATH = "./best_1.pt"  # YOLO 모델 경로를 설정하세요
detector = YOLO(BBS_MODEL_PATH)
predictor = dlib.shape_predictor("./shape_predictor_68_face_landmarks.dat")
hat_path = './hat.png'

# 이미지 파일이 저장된 디렉토리 경로
image_dir = 'https://04da-221-145-193-52.ngrok-free.app/images/'

@app.get("/")
async def read_root():
    logger.info("Root URL was requested")
    return "테스트 실행"

@app.post("/predict")
async def predict_image(file: UploadFile = File(...)):
    file_location = f"temp_{file.filename}"
    try:
        # 파일을 서버에 저장
        with open(file_location, "wb") as f:
            f.write(await file.read())
        logger.info("File saved at %s", file_location)
        
        # 이미지 예측
        prediction_result = xception_prediction_model.load_and_predict(model, file_location)
        logger.info("Prediction result for %s: %s", file_location, prediction_result)
        
        return prediction_result
    except Exception as e:
        logger.error("Prediction failed: %s", e)
        raise HTTPException(status_code=500, detail="Internal Server Error")
    finally:
        if os.path.exists(file_location):
            os.remove(file_location)

@app.post("/generate_image_caption")
async def generate_image_caption(file: UploadFile = File(...)):
    file_location = f"temp_{file.filename}"
    try:
        # 파일을 서버에 저장
        with open(file_location, "wb") as f:
            f.write(await file.read())
        logger.info("File saved at %s", file_location)
        
        # 이미지 캡션 생성
        captions = vertexai_model.generate_captions(file_location, num_results=3, language="en")
        logger.info("Generated captions: %s", captions)

        # 캡션을 한글로 번역
        captions_korean = [translate_to_korean(caption) for caption in captions]
        logger.info("Generated captions in Korean: %s", captions_korean)
        
        return JSONResponse(content={"captions": captions_korean})
    except Exception as e:
        logger.error("Caption generation failed: %s", e)
        raise HTTPException(status_code=500, detail="Internal Server Error")
    finally:
        if os.path.exists(file_location):
            os.remove(file_location)

@app.post("/detect_head")
async def detect_head(file: UploadFile = File(...)):
    file_location = f"temp_{file.filename}"

    try:
        # 파일 저장
        with open(file_location, "wb") as f:
            f.write(await file.read())
        logger.info(f"File saved at {file_location}")

        # 이미지 읽기
        image = cv2.imread(file_location)
        if image is None:
            raise ValueError("이미지를 읽을 수 없습니다")
        logger.info(f"Client Image Size: {image.shape[1]}x{image.shape[0]}")

        # YOLO 모델을 사용하여 객체 감지
        results = detector(image)
        logger.info("Detection completed")

        if not results or len(results) == 0:
            raise ValueError("검출된 객체가 없습니다")

        best_box = None
        max_area = 0

        # 감지된 바운딩 박스 중 가장 큰 면적을 가진 박스 선택
        for result in results:
            if hasattr(result, 'boxes') and result.boxes is not None:
                boxes = result.boxes
                for box in boxes:
                    confidence = box.conf[0]
                    x1, y1, x2, y2 = box.xyxy[0].tolist()
                    x1, y1, x2, y2 = int(x1), int(y1), int(x2), int(y2)
                    logger.info(f"Detected box: ({x1}, {y1}), ({x2}, {y2}) with confidence {confidence}")

                    # 박스 면적 계산
                    area = (x2 - x1) * (y2 - y1)

                    # 면적이 더 큰 박스를 찾기
                    if area > max_area:
                        max_area = area
                        best_box = (x1, y1, x2, y2)

        if best_box is not None:
            x1, y1, x2, y2 = best_box
            logger.info(f"Best box: ({x1}, {y1}), ({x2}, {y2}) with area {max_area}")

            # 바운딩 박스 그리기
            cv2.rectangle(image, (x1, y1), (x2, y2), (0, 255, 0), 2)

            # 얼굴 인식 후 모자 오버레이
            gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
            rect = dlib.rectangle(x1, y1, x2, y2)
            
            try:
                shape = predictor(gray_image, rect)
                num_parts = len(shape.parts())
                
                # 랜드마크 포인트 수 확인
                if num_parts < 17:
                    raise ValueError(f"랜드마크 포인트가 부족합니다. 발견된 포인트 수: {num_parts}")

                # 랜드마크 포인트를 기반으로 모자 위치 설정
                hat_center = [shape.part(0).x, shape.part(0).y - 7]
                hat = cv2.imread(hat_path, cv2.IMREAD_UNCHANGED)
                hat_size = np.linalg.norm(
                    np.array([shape.part(16).x, shape.part(16).y]) - np.array([shape.part(0).x, shape.part(0).y])
                )
                hat = cv2.resize(hat, (int(hat_size), int(hat_size)))

                # 오버레이 이미지 위치 검증 및 조정
                if hat_center[1] - hat.shape[0] // 2 < 0:
                    hat_center[1] = hat.shape[0] // 2
                if hat_center[0] - hat.shape[1] // 2 < 0:
                    hat_center[0] = hat.shape[1] // 2
                if hat_center[1] + hat.shape[0] // 2 > image.shape[0]:
                    hat_center[1] = image.shape[0] - hat.shape[0] // 2
                if hat_center[0] + hat.shape[1] // 2 > image.shape[1]:
                    hat_center[0] = image.shape[1] - hat.shape[1] // 2

                result_image = overlay_transparent(image, hat, hat_center[0], hat_center[1], overlay_size=(hat.shape[1], hat.shape[0]))

            except Exception as e:
                logger.error(f"Face landmark detection failed: {e}")
                raise HTTPException(status_code=500, detail=f"Face landmark detection failed: {e}")

        else:
            raise ValueError("검출된 바운딩 박스가 없습니다")

        # YOLO 모델에서 나온 이미지 크기 출력
        logger.info(f"YOLO Image Size: {image.shape[1]}x{image.shape[0]}")

        # 클라이언트에 전송하기 전에 이미지 크기 출력
        _, buffer = cv2.imencode('.jpg', result_image)
        img_stream = io.BytesIO(buffer)
        logger.info(f"Final Image Size to Client: {result_image.shape[1]}x{result_image.shape[0]}")

        return StreamingResponse(img_stream, media_type="image/jpeg", headers={"Content-Disposition": "inline; filename=output.jpg"})

    except ValueError as e:
        logger.error(f"ValueError: {e}")
        raise HTTPException(status_code=400, detail=f"ValueError: {e}")

    except Exception as e:
        logger.error(f"머리 감지 실패: {e}")
        raise HTTPException(status_code=500, detail=f"머리 감지 실패: {e}")

    finally:
        if os.path.exists(file_location):
            os.remove(file_location)
            logger.info(f"File deleted: {file_location}")
            
@app.get("/random_images")
async def get_random_images(num_images: int = 10):
    try:
        # 이미지 파일이 저장된 디렉토리
        image_directory = 'C:/Study/archive/images'
        
        # 디렉토리의 모든 이미지 파일 목록 가져오기
        image_files = [f for f in os.listdir(image_directory) if f.endswith('.jpg')]
        
        if not image_files:
            raise ValueError("디렉토리에 이미지 파일이 없습니다")

        # 랜덤으로 이미지 파일 선택
        random_image_files = random.sample(image_files, min(num_images, len(image_files)))
        
        # 이미지 파일 URL 생성
        image_urls = [f"{image_dir}{img}" for img in random_image_files]
        
        return JSONResponse(content={"images": image_urls})
    
    except Exception as e:
        logger.error(f"Failed to get random images: {e}")
        raise HTTPException(status_code=500, detail="Internal Server Error")
    
# 이미지 파일 서빙 엔드포인트 추가
app.mount("/images", StaticFiles(directory="C:/Study/archive/images"), name="images")

# 예외 처리기 추가
@app.exception_handler(RequestValidationError)
async def validation_exception_handler(request, exc):
    return JSONResponse(
        status_code=422,
        content={"detail": exc.errors()},
    )

@app.exception_handler(HTTPException)
async def http_exception_handler(request, exc):
    return JSONResponse(
        status_code=exc.status_code,
        content={"detail": exc.detail},
    )

if __name__ == "__main__":
    uvicorn.run(
        "xception_server:app",
        reload=True,
        host="0.0.0.0",
        port=5000,
        log_level="info"
    )

# overlay function
def overlay_transparent(background_img, img_to_overlay_t, x, y, overlay_size=None):
    bg_img = background_img.copy()
    
    if bg_img.shape[2] == 3:
        bg_img = cv2.cvtColor(bg_img, cv2.COLOR_BGR2BGRA)

    if overlay_size is not None:
        img_to_overlay_t = cv2.resize(img_to_overlay_t.copy(), overlay_size)
    
    b, g, r, a = cv2.split(img_to_overlay_t)
    mask = cv2.medianBlur(a, 5)
    mask = mask.astype(np.uint8)
    h, w, _ = img_to_overlay_t.shape

    # 배경 이미지의 경계 내에 오버레이 이미지가 있도록 검증합니다.
    if (y - h//2 < 0 or x - w//2 < 0 or
        y + h//2 > bg_img.shape[0] or x + w//2 > bg_img.shape[1]):
        raise ValueError("Overlay position is out of bounds of the background image")

    roi = bg_img[int(y - h//2):int(y + h//2), int(x - w//2):int(x + w//2)]

    if roi.shape[0] != h or roi.shape[1] != w:
        # 오버레이 이미지 크기와 ROI 크기를 맞추기 위해 조정
        h = min(roi.shape[0], h)
        w = min(roi.shape[1], w)
        img_to_overlay_t = cv2.resize(img_to_overlay_t, (w, h))
        b, g, r, a = cv2.split(img_to_overlay_t)
        mask = cv2.medianBlur(a, 5)
        mask = mask.astype(np.uint8)

    img1_bg = cv2.bitwise_and(roi.copy(), roi.copy(), mask=cv2.bitwise_not(mask))
    img2_fg = cv2.bitwise_and(img_to_overlay_t, img_to_overlay_t, mask=mask)
    bg_img[int(y - h//2):int(y + h//2), int(x - w//2):int(x + w//2)] = cv2.add(img1_bg, img2_fg)
    bg_img = cv2.cvtColor(bg_img, cv2.COLOR_BGRA2BGR)
    return bg_img