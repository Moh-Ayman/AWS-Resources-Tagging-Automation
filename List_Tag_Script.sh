#!/bin/bash
#set -x
echo service_name,resource_id,tag1Key,tag1Value,tag2Key,tag2Value,tag3Key,tag3Value,tag4Key,tag4Value > lookupfile

aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId]" --output text | awk '{ print "ec2," $0; }' >> lookupfile
aws ec2 describe-images --owner self --query "Images[*].[ImageId]" --output text | awk '{ print "image," $0; }' >> lookupfile
aws ec2 describe-security-groups --query "SecurityGroups[*].[GroupId]" --output text | awk '{ print "sg," $0; }' >> lookupfile
aws ec2 describe-vpcs --query "Vpcs[*].[VpcId]" --output text | awk '{ print "vpc," $0; }' >> lookupfile
aws ec2 describe-subnets --query "Subnets[*].[SubnetId]" --output text | awk '{ print "subnet," $0; }' >> lookupfile
aws ec2 describe-route-tables --query "RouteTables[*].[RouteTableId]" --output text | awk '{ print "rt," $0; }' >> lookupfile
aws elbv2 describe-load-balancers --query "LoadBalancers[*].[Type,LoadBalancerArn]" --output text | grep application | awk '{ print $2; }' | awk '{ print "alb," $0; }' >> lookupfile
aws elbv2 describe-load-balancers --query "LoadBalancers[*].[Type,LoadBalancerArn]" --output text | grep network | awk '{ print $2; }' | awk '{ print "nlb," $0; }' >> lookupfile
aws elbv2 describe-target-groups --query "TargetGroups[*].[TargetGroupArn]" --output text | awk '{ print "tg," $0; }' >> lookupfile
aws elbv2 describe-load-balancers --query "LoadBalancers[*].[LoadBalancerArn]" --output text | while read line
do 
        aws elbv2 describe-listeners --load-balancer-arn $line --query "Listeners[*].[ListenerArn]" --output text | awk '{ print "listener," $0; }' >> lookupfile
done
aws ec2 describe-nat-gateways --query "NatGateways[*].[NatGatewayId]" --output text | awk '{ print "ngw," $0; }' >> lookupfile
aws ec2 describe-transit-gateways --query "TransitGateways[*].[TransitGatewayId]" --output text | awk '{ print "tgw," $0; }' >> lookupfile
aws s3api list-buckets --query "Buckets[].Name" --output text | sed 's/\t\t*/\n/g' | awk '{ print "s3," $0; }' >> lookupfile
aws cloudtrail list-trails --query "Trails[*].[TrailARN]" --output text | awk '{ print "trail," $0; }' >> lookupfile
aws rds describe-db-instances --query "DBInstances[*].[DBInstanceArn]" --output text | awk '{ print "rds," $0; }' >> lookupfile


sed 1d lookupfile | while IFS= read -r line
do
        servicename=`echo $line | cut -d "," -f1`
        ID=`echo $line | cut -d "," -f2`
        case $servicename in

             ec2)
                 echo ec2
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
#set +x
