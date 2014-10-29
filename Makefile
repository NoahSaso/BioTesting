ARCHS = arm64
TARGET = iphone:clang:latest

include theos/makefiles/common.mk

TWEAK_NAME = BioTesting
BioTesting_FILES = Tweak.xm BTTouchIDController.m
BioTesting_FRAMEWORKS = UIKit
BioTesting_PRIVATE_FRAMEWORKS = BiometricKit
#BioTesting_CODESIGN_FLAGS = -SEntitlements.plist # Works without this line

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
