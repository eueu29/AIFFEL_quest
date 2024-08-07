import os, re
import numpy as np
import tensorflow as tf
from tensorflow.keras.applications import Xception
from tensorflow.keras.models import load_model
from tensorflow.keras.layers import Dense, GlobalAveragePooling2D, BatchNormalization, Dropout
from tensorflow.keras.preprocessing.image import load_img, img_to_array

# 이미지 파일이 저장된 디렉토리 경로
input_dir = "C:/Study/archive/images/"

# 이미지 파일 경로를 수집합니다.
input_img_paths = [os.path.join(input_dir, fname)
                   for fname in os.listdir(input_dir)
                   if fname.endswith(".jpg")]

def extract_class_name(filename):
    """
    파일 이름에서 클래스 이름을 추출하고 숫자를 제거하며,
    언더바를 공백으로 바꿉니다.
    """
    base_name = os.path.splitext(filename)[0]  # 파일 이름에서 확장자를 제거합니다.
    class_name = re.sub(r'\d+', '', base_name).replace('_', ' ').strip()  # 숫자 제거 및 언더바 변환
    return class_name

# 클래스 이름을 추출하고 중복을 제거하며 정렬합니다.
class_names = sorted(set(extract_class_name(fname) for fname in os.listdir(input_dir) if fname.endswith('.jpg')))

def load_model_custom():
    model_path = os.path.expanduser('./xception_model.keras')
    try:
        if not os.path.exists(model_path):
            raise FileNotFoundError(f"Model file not found: {model_path}")
        model = load_model(model_path, custom_objects={
            'Xception': Xception,
            'GlobalAveragePooling2D': GlobalAveragePooling2D,
            'Dense': Dense,
            'BatchNormalization': BatchNormalization,
            'Dropout': Dropout
        })
        return model
    except Exception as e:
        raise RuntimeError(f"Failed to load model: {e}")

def load_and_predict(model, img_path):
    try:
        img = load_img(img_path, target_size=(299, 299))
        img_array = img_to_array(img)
        img_array = np.expand_dims(img_array, axis=0)
        img_array = tf.keras.applications.xception.preprocess_input(img_array)
        
        predictions = model.predict(img_array)
        predicted_class = np.argmax(predictions, axis=1)[0]
        predicted_label = class_names[predicted_class]
        
        return {
            "predicted_label": predicted_label,
            "prediction_score": f"{predictions[0][predicted_class]:.5f}"
        }
    except Exception as e:
        return {"error": str(e)}