### Author @Varun Sharma - Tuplejump, Inc.

### To start casssandra cluster follow these steps.

Latest README - Updated on 15th June, 2015

########
Technologies used:

Vagrant, CoreOS, Docker, shell scripts

Steps:

1. change the directory to the package.

    $cd tuplejump_cassandra

2. check whether coreos is running or not, if running then 

    $vagrant status
    
    if no machine is up then we can go ahead and start cluster
    
    if there are machines up and running
    
    $./reset.sh
    

3. start a cassandra cluster of 5 nodes.

    $./start.sh 5 stable
    
    5 - no. of nodes
    
    stable - stable coreos version 

4. login in coreos instance

    $vagrant ssh core-01

5. check running cluster on coreOS > core-01

    $fleetctl list-machines

6. change the directory /home/core/shared/

    $cd shared

7. start cassandra cluster on docker

    $./ start_docker_container_fleetctl.sh

8. check docker container status, this command will list out container running.

    $docker ps -a

9. log into docker container

    $docker attach docker-container_id (press enter(button) if the result is blank.
    
    docker-container_id: first three digits of container id.

10. Once logged into container check processes to confirm cassandra is running:\

     $ps 

11. check cassandra cluster status by using nodetool

      $/opt/apache-cassandra-2.0.9/bin/nodetool -h localhost status

######################################################
OLD README file below - depricated
######################################################
1. run script start.sh with arguments
 Ex: ./start.sh arg1 arg2
     where arg1 is number of instances & arg2 is coreOS box version(alpha, beta or stable)   


2. By default only first instance is added as seed. 
   To Add more seeds please edit - Vagrantfile
   - Go to line number: 115
   - add arguments to script after config_cass.sh arg1,  add ip addresses seperated with commas as argument to this script. These ipaddresses are without spaces.

 Ex: line 115:  config.vm.provision "shell", path: "./docker/config_cass.sh arg1"
  where arg1 is 1.1.1.1,2.2.2.2,3.3.3.3

 Note: Do not add spaces in arg1 with config_cass.sh

## And you are game with cassandra cluster in few minutes.

After launching cassandra cluster, start fleet service as mentioned below.
1. Install fleet in your base machine
git clone https://github.com/coreos/fleet.git


2. run commands:
  a. fleetctl list-machines
     This lists out number of instances just created.

  b. fleetctl submit ./docker/cassandra-cluster.service

  c. fleetctl status cassandra-cluster.service

  d. *fleetctl journal cassandra-cluster.service (\* Optional to verify if everythig is working fine)

3. At last from base directory, cd ./docker
4. cd apache-cassandra-2.0.9/bin/nodetool status 
	Refer nodetool documentation for further actions on cluster
##
Dockers can be accessed from commands manetioned below:
1. Go to base directory
   a. vagrant ssh core-01
   On coreOS instance run;
   b. docker images (to check images on this coreOS)
   c. docker ps -a (to check containers)
   d. docker attach ContainerID (attach to container which is up, or else start if exited)
 Note: do not exit from container, if exited the container stops. press CTRL+P+Q to exit without stopping.


#######################
reset.sh
######################
execution of this script will reset config.rb and user-data both and removes vagrant boxes if exists.
	 
