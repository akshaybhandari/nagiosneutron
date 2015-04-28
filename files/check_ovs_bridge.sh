#!/bin/bash
#
# OpenstacK monitoring script for Nagios
# This script checks if the specified ovs bridge is present or not
#
# Author: Akshay Bhandari
#

OK=0
WARNING=1
CRITICAL=2
UNKNOWN=3

usage()
{
cat <<EOF

Check if the specified bridge is present on the host.

     Options:
        -h              Print help(this message) and exit
        -b <bridge>     Specify bridge name(default: br-ex)
EOF
}

BRIDGE='br-ex'

while getopts 'hb:' OPTION
do 
    case $OPTION in
        h) 
            usage
            exit 0
            ;;
        b)
            export BRIDGE=$OPTARG
            ;;
        *)
            usage
            exit 1
            ;;
    esac
done

if ! which ovs-vsctl >/dev/null 2>&1
then
    echo "UNKNOWN: ovs-vsctl command not found"
    exit $UNKNOWN
fi

ovs-vsctl br-exists $BRIDGE >/dev/null 2>&1

case $? in
    0)
        echo "OK: Bridge $BRIDGE exists"
        exit $OK
        ;;
    2)
        echo "CRITICAL: Bridge $BRIDGE does not exists"
        exit $CRITICAL
        ;;
    *)
        echo "UNKNOWN: Openvswitch failed to detect bridge"
        exit $UNKNOWN
        ;;
esac
