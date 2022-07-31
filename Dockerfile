FROM docker.io/library/alpine:latest
RUN apk update && apk --no-cache add bash curl fish git python3 starship
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN curl -Ss https://raw.githubusercontent.com/dylanaraps/pfetch/master/pfetch > /usr/local/bin/pfetch \
      && chmod 755 /usr/local/bin/pfetch
COPY ./ /dotfiles
RUN /dotfiles/install
CMD fish -l
