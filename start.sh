#!/bin/bash

# This vagrant package starts cluster as soon as 
# ./start.sh args1 args2 
# is run. args1 = Number of instances
# args2 = coreOS version (stable / beta / alpha)
# Argument 3 : These are the ip addresses of the cassandra instances which are seeds
# Argumnet 3: values are comma seperated without spaces. 
# Agrument 3 Example: 1.2.3.4, 7.8.7.8,
# All values entered are with commas

# We recommend using alpha.
# Alpha will support all Fleetctl configurations to run a server.

# Author: @Varun Sharma. Tuplejump, Inc.

# Usage: ./start.sh Num_of_instances alpha/beta/stable 

if [ -z "$*" ]; then 
 echo "No Arguments entered!!
 Usage: ./start.sh Arg1(Number of instances in cluster) Arg2(Vagrant version-Alpha, beta or stable)"
 exit 0
fi

# Define Variables

# Clearing pre-existing cluster
vagrant destroy -f

#Using latest vagrant images 
#vagrant box update 

#Take command line argument, for select number of nodes needed
#this will update config.rb

sed -i -e "s/#\$num_instances=.*/\$num_instances=$1/" ./config.rb

sed -i -e "s/#\$update_channel=.*/\$update_channel='$2'/" ./config.rb

`curl -s https://discovery.etcd.io/new > discovery.token`

sed -i -e "s,#discovery: https://discovery.etcd.io/<token>,discovery: $(sed 's:/:\\/:g' discovery.token)," ./user-data

#Ensuring SSH key is added 
#eval "ssh-agent -s"
#exec "ssh-agent bash"
eval $(ssh-agent)


echo $SSH_AUTH_SOCK
ssh-add ~/.vagrant.d/insecure_private_key
 
#Start the cluster
vagrant up --provision

# remove discovery.token file after use
rm -rf discovery.token

#awk '/addr: $public_ipv4:4001/{print "#discovery: https://discovery.etcd.io/<token>"}1' ./user-data
#awk '/$num_instances=.*/{print "#$num_instances=1"}1' ./config.rb



 
