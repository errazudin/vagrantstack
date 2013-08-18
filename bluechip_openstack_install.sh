#!/bin/bash

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "You need to be 'root' dude." 1>&2
   exit 1
fi

# just so we're all clear
clear 

# see if we have our setuprc file available and source it
if [ -f ./setuprc ]
then
  . ./setuprc
else
  echo "##########################################################################################################################"
  echo;
  echo "A setuprc config file wasn't found & the install must halt.  Report this at https://github.com/bluechiptek/bluechipstack."
  echo;
  echo "##########################################################################################################################"
  exit;
fi

num_nodes=$NUMBER_NODES

echo "##########################################################################################################################"
echo;
echo "Use the folowing ssh commands below to ssh to your target nodes:" 
echo;

# loop through config's machines and add to /etc/hosts
for (( x=1; x<=$num_nodes; x++ ))
  do
    host="NODE_"$x"_HOSTNAME"
    ip="NODE_"$x"_IP"
    echo "${!ip}	${!host}" >> /etc/hosts
    echo "ssh ${!host}"
  done

echo;
echo "For each node run a 'sudo passwd root' and then enter '"$ROOT_PASSWD"' for the root password."
echo; 
echo "When you are done changing passwords for the nodes you may run './bluechip_openstack_push_client.sh' to continue."
echo;
echo "##########################################################################################################################"