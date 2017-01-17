#! /bin/bash

genetrees=$1
speciestree=$2

java -jar $astral -i $genetrees -o $speciestree
