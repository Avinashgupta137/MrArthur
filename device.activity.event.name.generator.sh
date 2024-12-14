#!/bin/bash
for i in {1..2500}
do
   echo "static let correction${i}EventName = Self(\"correction${i}EventName\")"
   #echo "$i times"
done
