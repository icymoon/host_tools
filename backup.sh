#!/bin/bash
#ID: 0x00007c00@gmail.com
if [ -d $1 ]; then
  d=$(cd $1; pwd)
  /bin/cp -R $d $d.$(date +%y%m%d_%H%M%S)
else
  /bin/cp $1 $1.$(date +%y%m%d_%H%M%S)
fi
