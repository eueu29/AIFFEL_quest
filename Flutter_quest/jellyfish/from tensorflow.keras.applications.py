from tensorflow.keras.applications.vgg16 import VGG16

#weight, include_top 파라미터 설정
model = VGG16(weights='imagenet', include_top=True)
model.summary()

#save model
model.save('vgg16.h5')