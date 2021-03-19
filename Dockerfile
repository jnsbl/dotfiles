FROM alpine
RUN apk update && apk --no-cache add bash curl fish git python2
COPY ./ /dotfiles
RUN /dotfiles/install
CMD fish -l