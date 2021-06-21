#!/usr/bin/env bash
#
# 2020 @leonjza
#
# Adjusted and repurposed from the frida-boot workshop
#  https://github.com/leonjza/frida-boot

if ! hash docker 2>/dev/null; then
    echo "Docker is required. Please install it first!"
    exit 1
fi

if ! [[ "$1" =~ ^(pull|build|run|shell)$ ]]; then
    echo "Usage: $0 [action]"
    echo " Actions can be: pull; build; run; shell"
    exit 1
fi

case $1 in

pull)
    echo "reserved for public. you can build it rather"
    ;;
build)
    echo "> building a local image"
    docker build -t report-generator .
    ;;
run)
    echo "> start a new container with the following command,"
    echo "  replacing FULL_PATH_TO_LOCAL_SRC_FOLDER with a"
    echo "  local directory to store your markdown files and images."
    echo "  Also, replacing FULL_PATH_TO_LOCAL_OUTPUT_FOLDER with a"
    echo "  local directory to store your final PDF and/or 7z archive."
    echo
    echo "docker run --rm -it" \
         "--name report-generator " \
         "-v FULL_PATH_TO_LOCAL_SRC_FOLDER:/root/report-generator/src" \
         "-v FULL_PATH_TO_LOCAL_OUTPUT_FOLDER:/root/report-generator/output" \
         "report-generator"
    echo
    echo "> IMPORTANT: Replace the FULL_PATH_TO_LOCAL_SRC_FOLDER section with the local" \
         "directory you want to store your markdown files and images in. ie: /home/jacquesc/src"
    echo "> IMPORTANT: Replace the FULL_PATH_TO_LOCAL_OUTPUT_FOLDER section with the local" \
         "directory you want to store your PDF and/or 7z archive in. ie: /home/jacquesc/output"
    ;;
shell)
    echo "> spawning new shell in the report-generator container"
    docker exec -it report-generator /bin/bash
    ;;
esac
