FROM golang:1.14-alpine

ENV DOCKER_HOME=/ngrok
ENV GOPROXY=https://goproxy.cn
WORKDIR $DOCKER_HOME

ADD ./sources.list /etc/apt/
ADD build.sh $DOCKER_HOME
RUN apk add --no-cache git make openssl \
    && git clone https://github.com/inconshreveable/ngrok.git --depth=1 $DOCKER_HOME \
    && sed -i "109,109s/tcp/tcp4/g" /ngrok/src/ngrok/server/tunnel.go \
    && sed -i  "57,57s/tcp/tcp4/g" /ngrok/src/ngrok/conn/conn.go \
    && sh $DOCKER_HOME/build.sh

EXPOSE 80 443
VOLUME [ "/ngrok" ]
#CMD [ "/ngrok/bin/ngrokd", "-domain=\"${NGROK_DOMAIN}\"", "-httpAddr=\":80\"", "-httpsAddr=\":443\""]
CMD [ "/ngrok/bin/ngrokd" ]