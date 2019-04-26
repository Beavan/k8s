# gcrxio mirror
#kubeadm config images list |sed -e 's/^/docker pull /g' -e 's#k8s.gcr.io#gcrxio#g' |sh -x
#docker images |grep gcrxio |awk '{print "docker tag ",$1":"$2,$1":"$2}' |sed -e 's#gcrxio#k8s.gcr.io#2' |sh -x
#docker images |grep gcrxio |awk '{print "docker rmi ", $1":"$2}' |sh -x

# aliyun mirror
kubeadm config images list |sed -e 's/^/docker pull /g' -e 's#k8s.gcr.io#registry.aliyuncs.com/google_containers#g' |sh -x
docker images |grep aliyuncs |awk '{print "docker tag ",$1":"$2,$1":"$2}' |sed -e 's#registry.aliyuncs.com/google_containers#k8s.gcr.io#2' |sh -x
docker images |grep aliyuncs |awk '{print "docker rmi ", $1":"$2}' |sh -x
