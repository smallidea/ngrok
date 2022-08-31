<!--
 * @Date: 2022-08-30 18:06:06
 * @LastEditors: Jason Chen
 * @LastEditTime: 2022-08-30 18:51:28
 * @FilePath: /ngrok/deployment.md
-->


## 生成证书
```
# 这里替换为自己的独立域名
export NGROK_DOMAIN="agent.ws-test.smartide.cn" #进入到ngrok目录生成证书

# 下面的命令用于生成证书
openssl genrsa -out rootCA.key 2048openssl req -x509 -new -nodes -key rootCA.key -subj "/CN=$NGROK_DOMAIN" -days 5000 -out rootCA.pem
openssl genrsa -out device.key 2048openssl req -new -key device.key -subj "/CN=$NGROK_DOMAIN" -out device.csr
openssl x509 -req -in device.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out device.crt -days 5000

# 将我们生成的证书替换ngrok默认的证书
cp rootCA.pem assets/client/tls/ngrokroot.crt
cp device.crt assets/server/tls/snakeoil.crt
cp device.key assets/server/tls/snakeoil.key

# 清理文件
rm rootCA.key
rm device.crt
rm device.key
```

## 编译不同平台的服务端和客户端
```
go env -w GO111MODULE=off

# 编译64位linux平台服务端
GOOS=linux GOARCH=amd64 make release-server

# 编译64位windows客户端
GOOS=windows GOARCH=amd64 make release-client

# 如果是mac系统，GOOS=darwin。如果是32位，GOARCH=386
```

## 打包成镜像
