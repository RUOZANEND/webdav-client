#!/bin/bash

# webdav地址，结尾需加/
WEBDAV_URL=https://webdav/

WEBDAV_USER=user
WEBDAV_PASSWORD=password

about()
{
  # Script Name: wdcli
  # Github: rvvcim/webdav-client
  # Author: RvvcIm  
  # License: MIT
  VERSION=1.0.1
}

webdav()
{
  curl -u ${WEBDAV_USER}:${WEBDAV_PASSWORD} "$@"
}

makedir()
{
  url="${WEBDAV_URL}${1}"
  webdav -X MKCOL "${url}"
  unset url
}

upload()
{
  file="${1}"
  url="${WEBDAV_URL}${2}"
  webdav -T "${file}" "${url}"
  unset url
}

download()
{
  url="${WEBDAV_URL}${1}"
  webdav -O "${url}"
  unset url
}

list()
{
  url="${WEBDAV_URL}${1}"
  webdav -X PROPFIND "${url}"
  unset url
}

move()
{
  source_url="${WEBDAV_URL}${1}"
  target_url="${WEBDAV_URL}${2}"
  webdav -X MOVE --header "Destination:${target_url}" "${source_url}"
}

copy()
{
    source_url="${WEBDAV_URL}${1}"
    target_url="${WEBDAV_URL}${2}"
    webdav -X COPY --header "Destination:${target_url}" "${source_url}"
}
remove()
{
  url="${WEBDAV_URL}${1}"
  webdav -X DELETE "${url}"
  unset url
}

if [ ! "$#" = 0 ]; then
    INCMD="$1"; shift
fi

case ${INCMD} in
    mkdir)
        makedir "$@"
    ;;
    push)
        upload "$@"
    ;;
    pull)
        download "$@"
    ;;
    ls)
        list "$@"
    ;;
    mv)
        move "$@"
    ;;
    cp)
        copy "$@"
    ;;
    rm)
        remove "$@"
    ;;
    help)
        about
        printf "
    Webdav Client\n\
    Version %s \n\
    help:\n\
        push <file> <dest>     上传文件\n\
        pull <file>            下载文件\n\
        mkdir <path>           新建文件夹\n\
        mv <file> <dest>       移动文件\n\
        cp <file> <dest>       复制文件\n\
        rm <file>              删除文件\n\
        ls <path>              显示文件列表\n\n\
        Tips: 除创建目录外，目录结尾均须带 / ,文件列表未作处理，为xml格式。
    " "${VERSION}"
    ;;
    *) printf "无事发生，试试输入 wdcli help ？\n";;
esac

exit 0