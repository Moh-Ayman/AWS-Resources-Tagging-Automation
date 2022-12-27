#!/bin/bash

lookupfile=$1
lookupdata=$(sed 1d $lookupfile)
for line in $lookupdata
do
        echo $line
        servicename=`echo $line | cut -d "," -f1`
        ID=`echo $line | cut -d "," -f2`
        Tags=`echo $line | cut -d "," -f4| sed -E 's/\|/ /g; s/;/,/g'`        
        case $servicename in
             ec2)
                 echo ec2
                 echo "aws ec2 create-tags --resources $ID --tags $Tags"
                 ;;

             image)
                  echo image
                  echo "aws ec2 create-tags --resources $ID --tags $Tags"
                  ;;

             sg)
                  echo sg
                  echo "aws ec2 create-tags --resources $ID --tags $Tags"
                  ;;

             vpc)
                  echo vpc
                  echo "aws ec2 create-tags --resources $ID --tags $Tags"
                  ;;

             subnet)
                  echo subnet
                  echo "aws ec2 create-tags --resources $ID --tags $Tags"
                  ;;

             rt)
                  echo routetable
                  echo "aws ec2 create-tags --resources $ID --tags $Tags"
                  ;;

             alb)
                  echo alb
                  echo "aws elbv2 add-tags --resource-arns $ID --tags $Tags"
                  ;;

             nlb)
                  echo nlb
                  echo "aws elbv2 add-tags --resource-arns $ID --tags $Tags"
                  ;;

             tg)
                 echo tg
                 echo "aws elbv2 add-tags --resource-arns $ID --tags $Tags"
                 ;;

         listener)
                 echo listener
                 echo "aws elbv2 add-tags --resource-arns $ID --tags $Tags"
                  ;;

             ngw)
                 echo ngw
                 echo "aws ec2 create-tags --resources $ID --tags $Tags"
                 ;;

             tgw)
                 echo tgw
                 echo "aws ec2 create-tags --resources $ID --tags $Tags"
                 ;;

              s3)
                 echo s3
                 Tags=`echo $line | cut -d "," -f4| sed -E 's/\|/ /g; s/;/,/g' | sed -E 's/^/{/g; s/$/}/g' | sed -E 's/ /},{/g'`
                 echo "aws s3api put-bucket-tagging --bucket $ID --tagging 'TagSet=[$Tags]'"
                 ;;

            trail)
                 echo trail
                 echo "aws cloudtrail add-tags --resource-id $ID --tags $Tags"
                 ;;

              rds)
                 echo rds
                 echo "aws rds add-tags-to-resource --resource-name $ID --tags $Tags"
                 ;;

               *)
                  echo ERROR
                   ;;
   esac
done
