#!/bin/bash
echo "--------------------------- Cấu hình máy chủ ---------------------------"
echo "Số lõi CPU: " $(nproc --all) "CORE"
echo -n "Dung lượng RAM: " && free -h | awk '/Mem/ {sub(/Gi/, " GB", $2); print $2}'
echo "Dung lượng ổ cứng:" $(df -B 1G --total | awk '/total/ {print $2}' | tail -n 1) "GB"
echo "------------------------------------------------------------------------"

echo "-------------------------- Cài đặt node Meson --------------------------"
# Lấy giá trị hash từ terminal
echo "Nhap token cua ban: "
read token

# Kiểm tra nếu hash_value là chuỗi rỗng (người dùng chỉ nhấn Enter) thì dừng chương trình
if [ -z "$token" ]; then
    echo "Không có giá trị token được nhập. Dừng chương trình."
    exit 1
fi

wget 'https://staticassets.meson.network/public/meson_cdn/v3.1.20/meson_cdn-linux-amd64.tar.gz'

tar -zxf meson_cdn-linux-amd64.tar.gz 
rm -f meson_cdn-linux-amd64.tar.gz

cd ./meson_cdn-linux-amd64 
sudo ./service install meson_cdn

sudo ./meson_cdn config set --token=$token --https_port=443 --cache.size=30

sudo ./service start meson_cdn