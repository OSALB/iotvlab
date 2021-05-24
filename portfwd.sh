#!/usr/bin/env bash

tcpPorts=(53)
udpPorts=(53)
gatewayInternalAddress=192.168.0.141
clientAddress=10.13.13.1

externalInterface="eth0"
internalInterface="wg0"

iptables -P FORWARD DROP

for port in "${tcpPorts[@]}"
do
	iptables -A FORWARD -i ${externalInterface} -o ${internalInterface} -p tcp --syn --dport ${port} -m conntrack --ctstate NEW -j ACCEPT -w
	iptables -A FORWARD -i ${externalInterface} -o ${internalInterface} -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT -w
	iptables -A FORWARD -i ${internalInterface} -o ${externalInterface} -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT -w

	iptables -t nat -A PREROUTING -i ${externalInterface} -p tcp --dport ${port} -j DNAT --to-destination ${clientAddress} -w
	iptables -t nat -A POSTROUTING -o ${internalInterface} -p tcp --dport ${port} -d ${clientAddress} -j SNAT --to-source ${gatewayInternalAddress} -w
done

for port in "${udpPorts[@]}"
do
        iptables -A FORWARD -i ${externalInterface} -o ${internalInterface} -p udp --dport ${port} -m conntrack --ctstate NEW -j ACCEPT -w
        iptables -A FORWARD -i ${externalInterface} -o ${internalInterface} -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT -w
        iptables -A FORWARD -i ${internalInterface} -o ${externalInterface} -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT -w

        iptables -t nat -A PREROUTING -i ${externalInterface} -p udp --dport ${port} -j DNAT --to-destination ${clientAddress} -w
        iptables -t nat -A POSTROUTING -o ${internalInterface} -p udp --dport ${port} -d ${clientAddress} -j SNAT --to-source ${gatewayInternalAddress} -w
done


