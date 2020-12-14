#!/bin/bash
# git上传代码
msg=""
if [ -z "$1" ];then
  msg=$(date)" 默认备注"
else
  msg=$1
fi
git add .
if [ $? -eq 0 ];then
  git commit -m "$msg"
  if [ $? -eq 0 ];then
    git push
  else
    echo "执行失败，请检查原因"
  fi
else
  echo "执行失败，请检查原因"
fi