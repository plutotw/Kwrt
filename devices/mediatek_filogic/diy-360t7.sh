#!/bin/bash
# 修改 DTS 分区表 (支持有无前导0的情况)
sed -i -E 's/reg = <0x0?580000 0x3a80000>/reg = <0x580000 0x6e00000>/g' target/linux/mediatek/dts/mt7981b-qihoo-360t7.dts
sed -i -E 's/reg = <0x(4000000|7300000) 0x0?([0-9a-f]+)>/reg = <0x7380000 0x400000>/g' target/linux/mediatek/dts/mt7981b-qihoo-360t7.dts

# 修改编译镜像大小和定义
sed -i '/define Device\/qihoo_360t7/,/endef/ {
    s/IMAGE_SIZE := .*/IMAGE_SIZE := 112640k/
    /DEVICE_VENDOR :=/a \\  IMAGES += factory.bin\\n  IMAGE/factory.bin := append-ubi | check-size $$$$(IMAGE_SIZE)
}' target/linux/mediatek/image/filogic.mk
