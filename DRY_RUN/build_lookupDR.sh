#!/bin/bash

Tag_1="Key=DR_Key_Tag_Number;Value=Tag_1|Key=DR_Key_Service;Value=AWSSerice|Key=DR_Key_App;Value=webserver|Key=DR_Key_DBType;Value=None|Key=DR_Key_Region;Value=Ireland"
Tag_2="Key=DR_Key_Tag_Number;Value=Tag_2|Key=DR_Key_Service;Value=AWSSerice|Key=DR_Key_App;Value=webserver|Key=DR_Key_DBType;Value=None"
Tag_3="Key=DR_Key_Tag_Number;Value=Tag_3|Key=DR_Key_Service;Value=AWSSerice"
Tag_4="Key=DR_Key_Tag_Number;Value=Tag_4"


file="ec2_lookupfile"
echo "ServiceType,ResourceID,ResourceName,Tags" > ec2_dummy_lookupfile
counter=0
while read LINE
do
  echo $LINE    
  if [ $counter -eq 0 ]
  then
    true
  elif [ $counter -eq 1 ]
  then
    echo $LINE | awk '{ print $0, "'"$Tag_1"'" }' | sed 's/ //g' >>  ec2_dummy_lookupfile
  elif [ $counter -eq 2 ]
  then
    echo $LINE | awk '{ print $0, "'"$Tag_2"'" }' | sed 's/ //g' >>  ec2_dummy_lookupfile
  elif [ $counter -eq 3 ]
  then
    echo $LINE | awk '{ print $0, "'"$Tag_3"'" }' | sed 's/ //g' >>  ec2_dummy_lookupfile
  elif [ $counter -eq 4 ]
  then
    echo $LINE | awk '{ print $0, "'"$Tag_4"'" }' | sed 's/ //g' >>  ec2_dummy_lookupfile
  elif [ $counter -ge 5 ]
  then
    exit
  fi
  ((counter++))
done < $file

file="sg_lookupfile"
echo "ServiceType,ResourceID,ResourceName,Tags" > sg_dummy_lookupfile
counter=0
while read LINE
do
  echo $LINE    
  if [ $counter -eq 0 ]
  then
    true
  elif [ $counter -eq 1 ]
  then
    echo $LINE | awk '{ print $0, "'"$Tag_1"'" }' | sed 's/ //g' >>  sg_dummy_lookupfile
  elif [ $counter -eq 2 ]
  then
    echo $LINE | awk '{ print $0, "'"$Tag_2"'" }' | sed 's/ //g' >>  sg_dummy_lookupfile
  elif [ $counter -eq 3 ]
  then
    echo $LINE | awk '{ print $0, "'"$Tag_3"'" }' | sed 's/ //g' >>  sg_dummy_lookupfile
  elif [ $counter -eq 4 ]
  then
    echo $LINE | awk '{ print $0, "'"$Tag_4"'" }' | sed 's/ //g' >>  sg_dummy_lookupfile
  elif [ $counter -ge 5 ]
  then
    exit
  fi
  ((counter++))
done < $file

file="vpc_lookupfile"
echo "ServiceType,ResourceID,ResourceName,Tags" > vpc_dummy_lookupfile
counter=0
while read LINE
do
  echo $LINE    
  if [ $counter -eq 0 ]
  then
    true
  elif [ $counter -eq 1 ]
  then
    echo $LINE | awk '{ print $0, "'"$Tag_1"'" }' | sed 's/ //g' >>  vpc_dummy_lookupfile
  elif [ $counter -eq 2 ]
  then
    echo $LINE | awk '{ print $0, "'"$Tag_2"'" }' | sed 's/ //g' >>  vpc_dummy_lookupfile
  elif [ $counter -eq 3 ]
  then
    echo $LINE | awk '{ print $0, "'"$Tag_3"'" }' | sed 's/ //g' >>  vpc_dummy_lookupfile
  elif [ $counter -eq 4 ]
  then
    echo $LINE | awk '{ print $0, "'"$Tag_4"'" }' | sed 's/ //g' >>  vpc_dummy_lookupfile
  elif [ $counter -ge 5 ]
  then
    exit
  fi
  ((counter++))
done < $files