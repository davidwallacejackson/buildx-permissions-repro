# syntax=docker/dockerfile:1.4
FROM ubuntu AS image-without-version-info

WORKDIR /home/user

RUN chgrp 0 /home/user && chmod g+rwX /home/user

FROM alpine as build-meta
ARG VERSION=0.0.1

RUN printf "version ${VERSION}" > /tmp/build.yaml 

FROM image-without-version-info as image-final
COPY --from=build-meta /tmp/build.yaml /home/user/build.yaml
