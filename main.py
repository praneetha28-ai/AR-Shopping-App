import cv2
import numpy as np

# Load input images
person_image = cv2.imread("E:\Virtual_Shopping\green_man.jpeg")

hsv=cv2.cvtColor(person_image,cv2.COLOR_BGR2HSV)

lower_green=np.array([25,52,72])
upper_green=np.array([102,255,255])

mask_white=cv2.inRange(hsv,lower_green,upper_green)
mask_black=cv2.bitwise_not(mask_white)

W,L=mask_black.shape 
mask_black_3CH=np.empty((W,L,3),dtype=np.uint8)
mask_black_3CH[:,:,0]=mask_black
mask_black_3CH[:,:,1]=mask_black
mask_black_3CH[:,:,2]=mask_black

cv2.imshow('original',person_image)
# cv2.imshow('mask_black',mask_black_3CH)

dst3=cv2.bitwise_and(mask_black_3CH,person_image)
# cv2.imshow('Pic+mask_inverse',dst3)

W,L=mask_white.shape
mask_white_3CH=np.empty((W,L,3),dtype=np.uint8)
mask_white_3CH[:,:,0]=mask_white
mask_white_3CH[:,:,1]=mask_white
mask_white_3CH[:,:,2]=mask_white

# cv2.imshow('mask_black',mask_black_3CH)
dst3_wh=cv2.bitwise_or(mask_white_3CH,dst3)
# cv2.imshow('design resize',dst3_wh)

design=cv2.imread("E:\Virtual_Shopping\gg.jpeg")
design=cv2.resize(design,mask_black.shape[1::-1])
cv2.imshow('design resize',design)

design_mask_mixed = cv2.bitwise_or(mask_black_3CH,design)
# cv2.imshow('design_mask_mixed',design_mask_mixed)

final_mask_black_3CH= cv2.bitwise_and(design_mask_mixed,dst3_wh)

cv2.imshow('final_out',final_mask_black_3CH)

cv2.waitKey(0)
cv2.destroyAllWindows()



