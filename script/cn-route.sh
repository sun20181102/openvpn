#!/bin/bash
ACTION=$1
GATEWAY=`ip route show 0.0.0.0/0|cut -d\  -f3`
CNCIDR_FILE='/var/cache/cn_cidr.cache'

if [ ! -f ${CNCIDR_FILE} ];then
    curl https://raw.githubusercontent.com/duxianghua/openvpn/master/cn_cidr.txt -o ${CNCIDR_FILE}
fi

case $ACTION in
    add)for i in `cat ${CNCIDR_FILE}`;do route add -net $i gw $GATEWAY;done
    ;;
    del)for i in `cat ${CNCIDR_FILE}`;do route del -net $i gw $GATEWAY;done
    ;;
    *)
    echo "Options error: $@"
    echo "Use $0 [add|del]"
esac
