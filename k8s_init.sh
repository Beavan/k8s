#!/bin/bash
  
match_repo=registry.k8s.io
replace_repo=registry.aliyuncs.com/google_containers

if [[ -n $1 ]];then
        match_repo=$1
fi

echo "match repo: $match_repo"
echo "replaced repo: $replace_repo"

## aliyun mirror
kubeadm config images list |grep -v coredns |sed -e 's/^/docker pull /g' -e "s#$match_repo#$replace_repo#g" |sh -x
# coredns单独处理/路径差异
kubeadm config images list |grep coredns |sed -e 's/^/docker pull /g' -e "s#$match_repo/coredns#$replace_repo#g" |sh -x
# update tags
docker images |grep aliyuncs |awk '{print "docker tag",$1":"$2,$1":"$2}' |sed -e "s#$replace_repo#$match_repo#2" |sh -x
# del temp images 
docker images |grep aliyuncs |awk '{print "docker rmi", $1":"$2}' |sh -x

