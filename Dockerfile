FROM alpine:3.7

RUN apk add --no-cache --virtual .build-deps g++ python3-dev libffi-dev openssl-dev && \
    apk add --no-cache --update python3 && \
    pip3 install --upgrade pip setuptools
    
RUN pip3 install awscli 

RUN wget https://releases.hashicorp.com/terraform/0.12.10/terraform_0.12.10_linux_amd64.zip

RUN unzip terraform_0.12.10_linux_amd64.zip

RUN mv terraform /usr/local/bin/terraform