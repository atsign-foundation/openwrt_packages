include $(TOPDIR)/rules.mk

PKG_NAME:=csshnpd
PKG_VERSION:=0.2.4
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-c$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/atsign-foundation/noports/releases/download/c$(PKG_VERSION)
PKG_HASH:=76ff5b62549681162c1c9e0faaa8eefbc9e1fb252e292be012a34d390ad63311

PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENCE

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-c$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

CMAKE_OPTIONS += \
		-S . \
		-DBUILD_SHARED_LIBS=off \
		-DBUILD_TESTS=off \
		-DCMAKE_C_COMPILER=$(TARGET_CC) \
		-DCMAKE_C_FLAGS="$(TARGET_CFLAGS) -Wno-calloc-transposed-args -Wno-error -pthread -lrt"

define Package/csshnpd
	SECTION:=net
	CATEGORY:=Network
	TITLE:=NoPorts Daemon
	URL:=https://noports.com
	SUBMENU:=SSH
endef

define Package/csshnpd/description
	A small and portable daemon for NoPorts.
endef

define Package/csshnpd/conffiles
	/etc/config/sshnpd
endef

define Package/csshnpd/install	
	$(INSTALL_DIR) \
	    $(1)/usr/bin \
		$(1)/etc/config \
		$(1)/etc/init.d
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/sshnpd/sshnpd $(1)/usr/bin/
	$(INSTALL_BIN) files/csshnpd.init $(1)/etc/init.d/sshnpd
	$(INSTALL_CONF) files/csshnpd.config \
	    $(1)/etc/config/sshnpd
endef

$(eval $(call BuildPackage,csshnpd))
