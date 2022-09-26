sudo docker run --name $1 --net host -e "FFR_NAME=$1" -e "LD_LIBRARY_PATH=/usr/lib/:/usr/local/lib/:/usr/lib/x86_64-linux-gnu:/usr/lib64/" -v /sys/class/:/sys/class/ -v /freeflow:/freeflow -v /dev/:/dev/ -v /home/huide/proj/:/opt/proj/ --privileged -it -d $2 /bin/bash

