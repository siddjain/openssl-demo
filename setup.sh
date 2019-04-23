#!/bin/bash
if [ ! -d newcerts ]; then
   mkdir newcerts
fi
if [ ! -f index.txt ]; then
   touch index.txt
fi
if [ -f serial ]; then
   # remove serial number file so that we get a new random serial number every time
   rm serial
fi
