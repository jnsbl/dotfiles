FROM alpine
RUN apk update && apk --no-cache add bash fish git python2
# RUN apk update && apk --no-cache add bash fish git py-pip python2 python2-dev
# FROM ubuntu:20.04
# RUN apt update && apt install -y bash fish git python3 python3-pip
COPY ./ /dotfiles
RUN /dotfiles/install
CMD fish -l