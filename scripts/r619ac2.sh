# Modify default IP
sed -i 's/192.168.1.1/192.168.2.10/g' package/base-files/files/bin/config_generate

# fix
sed -i '/CONFLICTS:=ethtool/d' package/network/utils/ethtool/Makefile

# 调整CFLAGS等级为O3
sed -i 's/Os/O3/g' include/target.mk

# 默认开启 Irqbalance
sed -i "s/enabled '0'/enabled '1'/g" feeds/packages/utils/irqbalance/files/irqbalance.config

# Add luci-theme-edge
git clone -b 18.06 --depth=1 https://github.com/garypang13/luci-theme-edge package/luci-theme-edge

# Add latest smartdns package
rm -rf feeds/packages/net/smartdns
svn co https://github.com/Lienol/openwrt-packages/trunk/net/smartdns feeds/packages/net/smartdns

# preset cores for openclash
mkdir -p files/etc/openclash/core
open_clash_main_url=$(curl -sL https://api.github.com/repos/vernesong/OpenClash/releases/tags/Clash | grep /clash-linux-armv8 | sed 's/.*url\": \"//g' | sed 's/\"//g')
clash_tun_url=$(curl -sL https://api.github.com/repos/vernesong/OpenClash/releases/tags/TUN-Premium | grep /clash-linux-armv8 | sed 's/.*url\": \"//g' | sed 's/\"//g')
clash_game_url=$(curl -sL https://api.github.com/repos/vernesong/OpenClash/releases/tags/TUN | grep /clash-linux-armv8 | sed 's/.*url\": \"//g' | sed 's/\"//g')
wget -qO- $open_clash_main_url | tar xOvz > files/etc/openclash/core/clash
wget -qO- $clash_tun_url | gunzip -c > files/etc/openclash/core/clash_tun
wget -qO- $clash_game_url | tar xOvz > files/etc/openclash/core/clash_game
chmod +x files/etc/openclash/core/clash*
