# "Database lookups" section;
# add in snmptraps.sh the following lines after the "community" assignment line

zabbixhost=$(HOME=/root mysql -N -e "select host from zabbix.hosts left join zabbix.interface on zabbix.hosts.hostid=zabbix.interface.hostid where ip='$hostname' order by 'hostid' limit 1;" 2>/dev/null)
[[ $zabbixhost ]] && HOST=$zabbixhost
