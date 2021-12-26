#/bin/sh

mkdir -p /tmp/smartdns/


wget -O /tmp/smartdns/china.conf https://ghproxy.fsou.cc/https://github.com/felixonmars/dnsmasq-china-list/blob/master/accelerated-domains.china.conf
wget -O /tmp/smartdns/apple.conf https://ghproxy.fsou.cc/https://github.com/felixonmars/dnsmasq-china-list/blob/master/apple.china.conf
wget -O /tmp/smartdns/google.conf https://ghproxy.fsou.cc/https://github.com/felixonmars/dnsmasq-china-list/blob/master/google.china.conf
wget -O /tmp/smartdns/bogus-nxdomain.conf https://ghproxy.fsou.cc/https://github.com/felixonmars/dnsmasq-china-list/blob/master/bogus-nxdomain.china.conf

#合并
cat /tmp/smartdns/apple.conf >> /tmp/smartdns/china.conf 2>/dev/null
cat /tmp/smartdns/google.conf >> /tmp/smartdns/china.conf 2>/dev/null

#删除不符合规则的域名
sed -i "s/^server=\/\(.*\)\/[^\/]*$/nameserver \/\1\/china/g;/^nameserver/!d" /tmp/smartdns/china.conf 2>/dev/null

mv -f /tmp/smartdns/china.conf  /etc/smartdns/smartdns-domains.china.conf
mv -f /tmp/smartdns/bogus-nxdomain.conf  /etc/smartdns/nxdomain.conf
rm -rf /tmp/smartdns/

/usr/bin/smartdns reload
