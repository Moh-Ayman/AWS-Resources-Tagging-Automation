#!/bin/bash

lookupfile=$1

lookupdata=$(sed 1d $lookupfile)
for line in $lookupdata
do
        servicename=`echo $line | cut -d "," -f1`
        ID=`echo $line | cut -d "," -f2`
        Tags=`echo $line | cut -d "," -f4| sed -E 's/\|/ /g; s/;/,/g'`
        
        case $servicename in

             ec2)
                 echo ec2a
                 aws ec2 create-tags --resources $ID --tags \"$Tags\"
                 ;;

             image)
                  echo image
                  aws ec2 create-tags --resources $ID --tags \"$Tags\"
                  ;;

             sg)
                  echo sg
                  aws ec2 create-tags --resources $ID --tags \"$Tags\"
                  ;;

             vpc)
                  echo vpc
                  aws ec2 create-tags --resources $ID --tags \"$Tags\"
                  ;;

             subnet)
                  echo subnet
                  aws ec2 create-tags --resources $ID --tags \"$Tags\"
                  ;;

             rt)
                  echo routetable
                  aws ec2 create-tags --resources $ID --tags \"$Tags\"
                  ;;

             alb)
                  echo alb
                  aws elbv2 add-tags --resource-arns $ID --tags \"$Tags\"
                  ;;

             nlb)
                  echo nlb
                  aws elbv2 add-tags --resource-arns $ID --tags \"$Tags\"
                  ;;

             tg)
                 echo tg
                 aws elbv2 add-tags --resource-arns $ID --tags \"$Tags\"
                 ;;

         listener)
                 echo listener
                  aws elbv2 add-tags --resource-arns $ID --tags \"$Tags\"
                  ;;

             ngw)
                 echo ngw
                 aws ec2 create-tags --resources $ID --tags \"$Tags\"
                 ;;

             tgw)
                 echo tgw
                 aws ec2 create-tags --resources $ID --tags \"$Tags\"
                 ;;

              s3)
                 echo s3
                 Tags=`echo $line | cut -d "," -f4| sed -E 's/\|/ /g; s/;/,/g' | sed -E 's/^/{/g; s/$/}/g' | sed -E 's/ /},{/g'`
                 aws s3api put-bucket-tagging --bucket $ID --tagging 'TagSet=[$Tags]'
                 ;;

            trail)
                 echo trail
                 aws cloudtrail add-tags --resource-id $ID --tags \"$Tags\"
                 ;;

              rds)
                 echo rds
                 aws rds add-tags-to-resource --resource-name $ID --tags \"$Tags\"
                 ;;

               *)
                  echo ERROR
                   ;;

   esac
  
done
