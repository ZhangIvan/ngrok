docker run -idt --name ngrok_server -p 80:80 -p 443:443 -p 4443:4443  -v /home/dxp/ngrok/ngrok:/myfiles -e DOMAIN='ngrok.demo.cn' hteen/ngrok /bin/sh /server.sh