#!/bin/bash

green='\033[0;32m'
# Clear the color after that
clear='\033[0m'

printf "${green}Creating/activating a docker-container builder:${clear}\n\n"
docker buildx create --use

printf "${green}Building a container where the working directory has permission drwxrwxr-x :${clear}\n\n"
docker buildx build --load --tag permission_repro:working_before_copy -f working_before_copy.Dockerfile .
docker run permission_repro:working_before_copy ls -la

printf "${green}Adding a COPY --link to the previous build; note the working directory now has permission drwxr-xr-x :${clear}\n\n"
docker buildx build --load --tag permission_repro:broken_after_copy_link -f broken_after_copy_link.Dockerfile .
docker run permission_repro:broken_after_copy_link ls -la

printf "${green}Changing the COPY --link to COPY; note the working directory again has permission drwxrwxr-x :${clear}\n\n"
docker buildx build --load --tag permission_repro:working_after_copy_without_link -f working_after_copy_without_link.Dockerfile .
docker run permission_repro:working_after_copy_without_link ls -la
