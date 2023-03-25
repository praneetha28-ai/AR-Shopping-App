import cv2
import numpy as np

# Load pre-trained models
pose_net = cv2.dnn.readNetFromTensorflow("pose_model.pb")
cloth_net = cv2.dnn.readNetFromTensorflow('cloth_detection.pb')

# Load input image and clothing image
input_img = cv2.imread('E:\Virtual_Shopping\origin_web.jpg')
cloth_img = cv2.imread('E:\Virtual_Shopping\cloth_web.jpg')

# Estimate pose of the person in the input image
pose_net.setInput(cv2.dnn.blobFromImage(input_img, 1.0, (368, 368), (0, 0, 0), swapRB=False, crop=False))
pose_output = pose_net.forward()

# Extract relevant part of the input image containing the person
person_mask = pose_output[0, 0, :, :]
person_mask = cv2.resize(person_mask, input_img.shape[:2][::-1])
person_mask = cv2.threshold(person_mask, 0.1, 1.0, cv2.THRESH_BINARY)[1]
person_mask = cv2.merge([person_mask, person_mask, person_mask])
person_img = input_img * person_mask

# Detect clothing in the input image
cloth_net.setInput(cv2.dnn.blobFromImage(person_img, 1.0, (300, 300), (104.0, 177.0, 123.0)))
cloth_output = cloth_net.forward()

# Extract relevant part of the clothing image
cloth_mask = cloth_output[0, 0, :, :]
cloth_mask = cv2.resize(cloth_mask, input_img.shape[:2][::-1])
cloth_mask = cv2.threshold(cloth_mask, 0.1, 1.0, cv2.THRESH_BINARY)[1]
cloth_mask = cv2.merge([cloth_mask, cloth_mask, cloth_mask])
cloth_img = cloth_img * cloth_mask

# Warp clothing image to fit the pose of the person
# This involves estimating the transformation that maps the clothing image to the pose of the person.
person_mask_gray = cv2.cvtColor(person_mask, cv2.COLOR_BGR2GRAY)
_, thresh = cv2.threshold(person_mask_gray, 10, 255, cv2.THRESH_BINARY)
contours, _ = cv2.findContours(thresh, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
cnt = contours[0]
(x, y, w, h) = cv2.boundingRect(cnt)
person_img_roi = person_img[y:y+h, x:x+w]
cloth_img_resized = cv2.resize(cloth_img, (w, h))
cloth_mask_resized = cv2.resize(cloth_mask, (w, h))
cloth_mask_resized = cv2.cvtColor(cloth_mask_resized, cv2.COLOR_BGR2GRAY)
_, cloth_mask_resized = cv2.threshold(cloth_mask_resized, 10, 255, cv2.THRESH_BINARY)
_, contours, _ = cv2.findContours(cloth_mask_resized, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
cnt = contours[0]
(x_cloth, y_cloth, w_cloth, h_cloth) = cv2.boundingRect(cnt)

M = cv2.estimateAffinePartial2D(cloth_img_resized[y_cloth:y_cloth+h_cloth, x_cloth:x_cloth+w_cloth], person_img_roi)[0]
                              
# Warp clothing image to fit the pose of the person
warped_cloth_img = np.zeros_like(person_img)
for i in range(3):
    warped_cloth_img[:, :, i] = cv2.warpAffine(cloth_img[:, :, i], M, (person_img.shape[1], person_img.shape[0]))
    
# Blend warped clothing image with the segmented input image to produce the final output image.
output_img = person_img.copy()
for i in range(3):
    output_img[:, :, i] = output_img[:, :, i] * (1 - cloth_mask[:, :, i]) + warped_cloth_img[:, :, i] * cloth_mask[:, :, i]

# Display output image
cv2.imshow('Output', output_img)
cv2.waitKey(0)
cv2.destroyAllWindows()

