#!/bin/bash
echo ServiceType,ResourceID,ResourceName,Tags > lookupfile

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
