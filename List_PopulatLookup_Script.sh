#!/bin/bash
echo ServiceType,ResourceID,ResourceName,Tags > ec2_lookupfile
echo ServiceType,ResourceID,ResourceName,Tags > images_lookupfile
echo ServiceType,ResourceID,ResourceName,Tags > sg_lookupfile
echo ServiceType,ResourceID,ResourceName,Tags > vpc_lookupfile
echo ServiceType,ResourceID,ResourceName,Tags > subnet_lookupfile
echo ServiceType,ResourceID,ResourceName,Tags > rt_lookupfile
echo ServiceType,ResourceID,ResourceName,Tags > alb_lookupfile
echo ServiceType,ResourceID,ResourceName,Tags > nlb_lookupfile
echo ServiceType,ResourceID,ResourceName,Tags > tg_lookupfile
echo ServiceType,ResourceID,ResourceName,Tags > listener_lookupfile
echo ServiceType,ResourceID,ResourceName,Tags > ngw_lookupfile
echo ServiceType,ResourceID,ResourceName,Tags > tgw_lookupfile
echo ServiceType,ResourceID,ResourceName,Tags > s3_lookupfile
echo ServiceType,ResourceID,ResourceName,Tags > trail_lookupfile
echo ServiceType,ResourceID,ResourceName,Tags > rds_lookupfile

#aws ec2 describe-instances --filters Name=tag-key,Values=Name --query "Reservations[*].Instances[*].{Instance:InstanceId,Name:Tags[?Key=='Name']|[0].Value}" --output text | awk '{ print "ec2," $0; }' | sed 's/\t/,/g' >> lookupfile
aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId]" --output text | awk '{ print "ec2," $0; }' | awk  '{ $(NF+1)=",,";}1' | sed 's/ //g' >> ec2_lookupfile
aws ec2 describe-images --owner self --query "Images[*].[ImageId]" --output text | awk '{ print "image," $0; }'| awk  '{ $(NF+1)=",,";}1' | sed 's/ //g' >> images_lookupfile
aws ec2 describe-security-groups --query "SecurityGroups[*].[GroupId]" --output text | awk '{ print "sg," $0; }'| awk  '{ $(NF+1)=",,";}1' | sed 's/ //g' >> sg_lookupfile
aws ec2 describe-vpcs --query "Vpcs[*].[VpcId]" --output text | awk '{ print "vpc," $0; }'| awk  '{ $(NF+1)=",,";}1' | sed 's/ //g' >> vpc_lookupfile
aws ec2 describe-subnets --query "Subnets[*].[SubnetId]" --output text | awk '{ print "subnet," $0; }'| awk  '{ $(NF+1)=",,";}1' | sed 's/ //g' >> subnet_lookupfile
aws ec2 describe-route-tables --query "RouteTables[*].[RouteTableId]" --output text | awk '{ print "rt," $0; }'| awk  '{ $(NF+1)=",,";}1' | sed 's/ //g' >> rt_lookupfile
aws elbv2 describe-load-balancers --query "LoadBalancers[*].[Type,LoadBalancerArn]" --output text | grep application | awk '{ print $2; }' | awk '{ print "alb," $0; }'| awk  '{ $(NF+1)=",,";}1' | sed 's/ //g' >> alb_lookupfile
aws elbv2 describe-load-balancers --query "LoadBalancers[*].[Type,LoadBalancerArn]" --output text | grep network | awk '{ print $2; }' | awk '{ print "nlb," $0; }'| awk  '{ $(NF+1)=",,";}1' | sed 's/ //g' >> nlb_lookupfile
aws elbv2 describe-target-groups --query "TargetGroups[*].[TargetGroupArn]" --output text | awk '{ print "tg," $0; }'| awk  '{ $(NF+1)=",,";}1' | sed 's/ //g' >> tg_lookupfile
aws elbv2 describe-load-balancers --query "LoadBalancers[*].[LoadBalancerArn]" --output text | while read line
do 
        aws elbv2 describe-listeners --load-balancer-arn $line --query "Listeners[*].[ListenerArn]" --output text | awk '{ print "listener," $0; }'| awk  '{ $(NF+1)=",,";}1' | sed 's/ //g' >> listener_lookupfile
done
aws ec2 describe-nat-gateways --query "NatGateways[*].[NatGatewayId]" --output text | awk '{ print "ngw," $0; }'| awk  '{ $(NF+1)=",,";}1' | sed 's/ //g' >> ngw_lookupfile
aws ec2 describe-transit-gateways --query "TransitGateways[*].[TransitGatewayId]" --output text | awk '{ print "tgw," $0; }'| awk  '{ $(NF+1)=",,";}1' | sed 's/ //g' >> tgw_lookupfile
aws s3api list-buckets --query "Buckets[].Name" --output text | sed 's/\t\t*/\n/g' | awk '{ print "s3," $0; }'| awk  '{ $(NF+1)=",,";}1' | sed 's/ //g' >> s3_lookupfile
aws cloudtrail list-trails --query "Trails[*].[TrailARN]" --output text | awk '{ print "trail," $0; }'| awk  '{ $(NF+1)=",,";}1' | sed 's/ //g' >> trail_lookupfile
aws rds describe-db-instances --query "DBInstances[*].[DBInstanceArn]" --output text | awk '{ print "rds," $0; }'| awk  '{ $(NF+1)=",,";}1' | sed 's/ //g' >> rds_lookupfile
