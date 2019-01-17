# "Database lookups" section;
# replace in the snmptraps.sh previously inserted 3 lines with the following

zabbixhostid=$(HOME=/root mysql -N -e "select hosts.hostid,host from
zabbix.hosts left join zabbix.interface on
zabbix.hosts.hostid=zabbix.interface.hostid where ip='$hostname' order
by 'hostid' limit 1;" 2>/dev/null)
zabbixhost=$(echo $zabbixhostid | cut -d" " -f2-)
[[ "$zabbixhost" ]] && {
     trapoid=$(echo $oid | cut -d: -f3)
    HOST=$zabbixhost
    trapoid=$(echo $oid | cut -d: -f3)
    if [ "$trapoid" ]; then
        zabbixid=$(echo $zabbixhostid | cut -d" " -f1)
        zabbixitem=$(HOME=/root mysql -N -e "select key_ from
zabbix.items where key_='$trapoid' and hostid='$zabbixid';" 2> /dev/null)
        if [ "$zabbixitem" ]; then
            KEY=$zabbixitem
        fi
    fi
}