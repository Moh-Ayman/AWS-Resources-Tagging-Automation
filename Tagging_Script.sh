#!/bin/bash

lookupfile=$1

sed 1d $lookupfile | while IFS= read -r line
do
        servicename=`echo $line | cut -d "," -f1`
        ID=`echo $line | cut -d "," -f2`
        case $servicename in

             ec2)
                 echo ec2a
                 aws ec2 create-tags --resources $ID --tags Key=Type,Value=Production
                 ;;

             image)
                  echo image
                  aws ec2 create-tags --resources $ID --tags Key=Type,Value=Production
                  ;;

             sg)
                  echo sg
                  aws ec2 create-tags --resources $ID --tags Key=Type,Value=Production
                  ;;

             vpc)
                  echo vpc
                  aws ec2 create-tags --resources $ID --tags Key=Type,Value=Production
                  ;;

             subnet)
                  echo subnet
                  aws ec2 create-tags --resources $ID --tags Key=Type,Value=Production
                  ;;

             rt)
                  echo routetable
                  aws ec2 create-tags --resources $ID --tags Key=Type,Value=Production
                  ;;

             alb)
                  echo alb
                  aws elbv2 add-tags --resource-arns $ID --tags Key=Type,Value=Production
                  ;;

             nlb)
                  echo nlb
                  aws elbv2 add-tags --resource-arns $ID --tags Key=Type,Value=Production
                  ;;

             tg)
                 echo tg
                 aws elbv2 add-tags --resource-arns $ID --tags Key=Type,Value=Production
                 ;;

         listener)
                 echo listener
                  aws elbv2 add-tags --resource-arns $ID --tags Key=Type,Value=Production
                  ;;

             ngw)
                 echo ngw
                 aws ec2 create-tags --resources $ID --tags Key=Type,Value=Production
                 ;;

             tgw)
                 echo tgw
                 aws ec2 create-tags --resources $ID --tags Key=Type,Value=Production
                 ;;

              s3)
                 echo s3
                 aws s3api put-bucket-tagging --bucket $ID --tagging 'TagSet=[{Key=Type,Value=Production}]'
                 ;;

            trail)
                 echo trail
                 aws cloudtrail add-tags --resource-id $ID --tags Key=Type,Value=Production
                 ;;

              rds)
                 echo rds
                 aws rds add-tags-to-resource --resource-name $ID --tags Key=Type,Value=Production
                 ;;

               *)
                  echo ERROR
                   ;;

   esac
  
done
