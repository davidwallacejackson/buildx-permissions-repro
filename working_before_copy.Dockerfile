# syntax=docker/dockerfile:1.4
FROM ubuntu AS image-without-version-info

WORKDIR /home/user

RUN chgrp 0 /home/user && chmod g+rwX /home/user
