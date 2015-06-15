#!/bin/bash

vagrant destroy -f

sed -i -e "s/\$num_instances=.*/#\$num_instances=1/" ./config.rb

sed -i -e "s/\$update_channel=.*/#\$update_channel=''/" ./config.rb

echo "https://discovery.etcd.io/<token>" > discovery.token

sed -i -e "s,    discovery: https://discovery.etcd.io/.*,    #discovery: $(sed 's:/:\\/:g' discovery.token)," ./user-data

rm discovery.token

rm -rf ~/.vagrant.d/
rm -rf ~/.fleetctl/


