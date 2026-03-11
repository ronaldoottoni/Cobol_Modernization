#!/bin/bash

mkdir -p objects

pwd 

ls -l

cobc -x src/PROGWEB.COB \
-I ./src/copy \
-o ./objects/PROGWEB

cobc -m src/PROG001.COB \
-I ./src/copy \
-o ./objects/PROG001.so

cobc -x src/MAINPROG.COB \
-I ./src/copy \
-o ./objects/MAINPROG