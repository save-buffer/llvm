FROM alpine
USER root

RUN apk add git && \
    apk add cmake && \
    apk add ninja && \
    apk add python3 && \
    apk add tar && \
    apk add build-base && \
    apk add binutils-gold && \
    git clone --depth 1 https://github.com/save-buffer/llvm-project /llvm-project

CMD ["/build_things.sh"]