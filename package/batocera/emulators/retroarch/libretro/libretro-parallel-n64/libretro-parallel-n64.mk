################################################################################
#
# PARALLEL_N64
#
################################################################################
# Version.: Commits on Feb 04, 2020 
LIBRETRO_PARALLEL_N64_VERSION = 519e642015cd6fa79047eb7ace18486f08176da8
LIBRETRO_PARALLEL_N64_SITE = $(call github,libretro,parallel-n64,$(LIBRETRO_PARALLEL_N64_VERSION))
LIBRETRO_PARALLEL_N64_LICENSE = GPLv2

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
	LIBRETRO_PARALLEL_N64_DEPENDENCIES += rpi-userland
endif

LIBRETRO_PARALLEL_N64_SUPP_OPT=
LIBRETRO_PARALLEL_N64_BOARD=

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RPI3),y)
	LIBRETRO_PARALLEL_N64_PLATFORM=rpi3

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RPI2),y)
	LIBRETRO_PARALLEL_N64_PLATFORM=rpi2

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_XU4)$(BR2_PACKAGE_BATOCERA_TARGET_LEGACYXU4),y)
	LIBRETRO_PARALLEL_N64_PLATFORM=odroid
	LIBRETRO_PARALLEL_N64_BOARD=ODROID-XU4

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_C2),y)
	LIBRETRO_PARALLEL_N64_SUPP_OPT=FORCE_GLES=1 ARCH=aarch64
	LIBRETRO_PARALLEL_N64_PLATFORM=unix

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_S905),y)
	LIBRETRO_PARALLEL_N64_SUPP_OPT=FORCE_GLES=1 ARCH=aarch64
	LIBRETRO_PARALLEL_N64_PLATFORM=unix

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_S912),y)
	LIBRETRO_PARALLEL_N64_SUPP_OPT=FORCE_GLES=1 ARCH=aarch64
	LIBRETRO_PARALLEL_N64_PLATFORM=unix

else ifeq ($(BR2_x86_i586),y)
	LIBRETRO_PARALLEL_N64_SUPP_OPT=ARCH=i386
	LIBRETRO_PARALLEL_N64_PLATFORM=unix

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_ROCKPRO64),y)
	LIBRETRO_PARALLEL_N64_PLATFORM=rockpro64

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_ROCK960),y)
	LIBRETRO_PARALLEL_N64_PLATFORM=rockpro64

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_ODROIDN2),y)
	LIBRETRO_PARALLEL_N64_PLATFORM=odroid
	LIBRETRO_PARALLEL_N64_BOARD=ODROIDN2

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_ODROIDGOA),y)
	LIBRETRO_PARALLEL_N64_PLATFORM=odroid
	LIBRETRO_PARALLEL_N64_BOARD=ODROIDGOA

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_TINKERBOARD),y)
	LIBRETRO_PARALLEL_N64_PLATFORM=tinkerboard
       
else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_MIQI),y)
	LIBRETRO_PARALLEL_N64_PLATFORM=tinkerboard
else
	LIBRETRO_PARALLEL_N64_PLATFORM=$(LIBRETRO_PLATFORM)
endif

define LIBRETRO_PARALLEL_N64_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" LD="$(TARGET_CXX)" \
		RANLIB="$(TARGET_RANLIB)" AR="$(TARGET_AR)" -C $(@D)/ -f Makefile platform="$(LIBRETRO_PARALLEL_N64_PLATFORM)" \
		BOARD="$(LIBRETRO_PARALLEL_N64_BOARD)" \
		$(LIBRETRO_PARALLEL_N64_SUPP_OPT)
endef

define LIBRETRO_PARALLEL_N64_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/parallel_n64_libretro.so \
	$(TARGET_DIR)/usr/lib/libretro/parallel_n64_libretro.so
endef

define PARALLEL_N64_CROSS_FIXUP
	$(SED) 's|/opt/vc/include|$(STAGING_DIR)/usr/include|g' $(@D)/Makefile
	$(SED) 's|/opt/vc/lib|$(STAGING_DIR)/usr/lib|g' $(@D)/Makefile
endef

PARALLEL_N64_PRE_CONFIGURE_HOOKS += PARALLEL_N64_FIXUP

$(eval $(generic-package))
