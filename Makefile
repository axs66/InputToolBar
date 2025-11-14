THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MyInputToolBar
MyInputToolBar_FILES = Tweak.xm MyToolBar.m
MyInputToolBar_FRAMEWORKS = UIKit Foundation
MyInputToolBar_ARCHS = arm64

include $(THEOS_MAKE_PATH)/tweak.mk
