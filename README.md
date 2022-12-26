# AWS-Resources-Tagging-Automation
**Project scope:**
- Is to list all resources under AWS Services to populate a lookup of all Resources with its coresponding ID or ARN &amp; its AWS Service. 

- And then to use manipulate Lookup to add Tags to it, where another script to loop and add the tags to all the mentioned resources. 

- All using AWS CLI.


**Usage Steps:**

  1- Start Bash Script: List_PopulatLookup_Script.sh 
    It will populate a Lookup contains all resources of AWS Services mentioned below.


  2- Edit the Lookup file to add the resource Tag Key & Value Field's
    Lookup File: lookupfile
    These Tag Field's Values will be used to populate tagging for these resources.
    
    Follow Below instructions to fill out the Lookup Tags as below lookup fields:
    
      a- ServiceType (Auto Filled by the List_PopulatLookup_Script.sh Script): Ex. EC2 / S3	
      
      b- ResourceID (Auto Filled by the List_PopulatLookup_Script.sh Script): EC2 Instances ID or the ARN Number.	
      
      c- ResourceName (Auto Filled by the List_PopulatLookup_Script.sh Script): Is the Name of the EC2 Instance.
      
      d- Tag_1: Tag will be shoud be filled following the naming convention <key;value>
      
      e- Tag_2:	Tag will be shoud be filled following the naming convention <key;value>
      
      f- Tag_3: Tag will be shoud be filled following the naming convention <key;value>
      
      g- Tag_4: Tag will be shoud be filled following the naming convention <key;value>



  3- Start Bash Script: Tagging_Script.sh 
    Where it will loop on the Lookup line by line and run tagging command corresponding to the Service mentioned in the script.


**Service Included** 

  1- EC2

  2- Images

  3- secgroup

  4- vpc

  5- subnets

  6- routetable

  7- alb
 
  8- nlb

  9- targetgroup

  10- listner

  11- natgateway

  12- Transit gateway

  13- S3

  14- Cloudtrail

  15- rds dbcluster/instance
