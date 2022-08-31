###
 # @Date: 2022-08-31 09:12:04
 # @LastEditors: Jason Chen
 # @LastEditTime: 2022-08-31 09:23:36
 # @FilePath: /ngrok/entrypoint_base.sh
### 

/ngrok/ngrokd -tlsKey=/ngrok/device.key -tlsCrt=/ngrok/device.crt -domain="agent.ws-test.smartide.cn" -httpAddr=":80" -httpsAddr=":8082" -tunnelAddr=":443"
