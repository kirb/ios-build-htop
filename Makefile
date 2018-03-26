include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/null.mk

export CC = xcrun -sdk iphoneos clang
export CPP = $(CC) -E

export CFLAGS = -isysroot $(SYSROOT) -I$(THEOS_PROJECT_DIR)/include -miphoneos-version-min=5.0 -arch $*
export CPPFLAGS = $(CFLAGS)
export LDFLAGS = -arch $*
export HOST = $(subst arm64,aarch64,$*)-apple-darwin

export CONFIGFLAGS = --host=$(HOST) --prefix=/usr --disable-linux-affinity

all:: htop.combined

htop.combined: $(foreach arch,$(ARCHS),htop.$(arch))
	lipo -create $^ -output $@

htop.%: clean htop/configure
	cd htop && ./configure $(CONFIGFLAGS)
	sed -i s/'#define HAVE_LIBNCURSESW 1'//g htop/config.h
	$(MAKE) -C htop clean all
	$(TARGET_CODESIGN) -Sentitlements.plist htop/htop
	mv htop/htop htop.$*

htop/configure:
	cd htop && ./autogen.sh

internal-clean::
ifneq ($(wildcard htop/Makefile),)
	$(MAKE) -C htop clean
	rm htop/Makefile
endif
ifneq ($(wildcard htop.*),)
	rm $(wildcard htop.*)
endif

internal-stage::
	mkdir -p $(THEOS_STAGING_DIR)/usr/bin
	cp htop.combined $(THEOS_STAGING_DIR)/usr/bin/htop
