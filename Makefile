#
# Copyright (C) 2021 ImmortalWrt
# <https://immortalwrt.org>
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=CloudflareSpeedTest
PKG_VERSION:=1.4.9
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/XIU2/CloudflareSpeedTest/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=7b7a18b54eae74d70f18105cc9c74822ce05336b2b894c59a388f46430733dcd

PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILE:=LICENSE
PKG_MAINTAINER:=CN_SZTL <cnsztl@immortalwrt.org>

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

GO_PKG:=CloudflareSpeedTest
GO_PKG_LDFLAGS:=-s -w

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/cdnspeedtest
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Getting the fastest ips of CDN to your network
	URL:=https://github.com/XIU2/CloudflareSpeedTest
	DEPENDS:=$(GO_ARCH_DEPENDS)
endef

define Package/cdnspeedtest/install
	$(call GoPackage/Package/Install/Bin,$(PKG_INSTALL_DIR))
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/CloudflareSpeedTest $(1)/usr/bin/cdnspeedtest

	$(INSTALL_DIR) $(1)/usr/share/CloudflareSpeedTest
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/ip.txt $(1)/usr/share/CloudflareSpeedTest/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/ipv6.txt $(1)/usr/share/CloudflareSpeedTest/
endef

$(eval $(call BuildPackage,cdnspeedtest))
