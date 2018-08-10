#! /bin/sh

set -e

MAX_MEMORY_MB=${MAX_MEMORY_MB:-1024}

[ ! -d /config/conf ] && cp -r /usr/local/crashplan/conf.default /config/conf
[ ! -d /config/log ] && cp -r /usr/local/crashplan/log.default /config/log
[ ! -d /config/crashplan ] && cp -r /var/lib/crashplan.default /config/crashplan
[ ! -f /config/ssh_host_ecdsa_key.pub ] && cp /etc/ssh/ssh_host_ecdsa_key.pub /config/ssh_host_ecdsa_key.pub
ln -fs /config/ssh_host_ecdsa_key.pub /etc/ssh/ssh_host_ecdsa_key.pub
sed -i 's/<location>.*<\/location>/<location>0.0.0.0:4242<\/location>/' /config/conf/my.service.xml
sed -i 's/<servicePort>.*<\/servicePort>/<servicePort>4243<\/servicePort>/' /config/conf/my.service.xml

cd /usr/local/crashplan
nice -n 19 /usr/local/crashplan/jre/bin/java \
	-Dfile.encoding=UTF-8 \
	-Dapp=CrashPlanService \
	-DappBaseName=CrashPlan \
	-Xms20m \
	-Xmx${MAX_MEMORY_MB}m \
	-Djava.net.preferIPv4Stack=true \
	-Dsun.net.inetaddr.ttl=300 \
	-Dnetworkaddress.cache.ttl=300 \
	-Dsun.net.inetaddr.negative.ttl=0 \
	-Dnetworkaddress.cache.negative.ttl=0 \
	-Dc42.native.md5.enabled=false \
	-classpath /usr/local/crashplan/lib/com.backup42.desktop.jar:/usr/local/crashplan/lang com.backup42.service.CPService
