import uvicorn
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

import vgg16_prediction_model  # 예측 모듈 가져오기

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

model = vgg16_prediction_model.load_model()

@app.get("/")
async def read_root():
    return "VGG16 모델을 사용하는 API입니다."

@app.get('/sample')
async def sample_prediction():
    result = await vgg16_prediction_model.prediction_model(model)
    return result

if __name__ == "__main__":
    uvicorn.run("server_fastapi_vgg16:app", reload=True, host="127.0.0.1", port=5000, log_level="info")
