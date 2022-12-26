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
    Tags Should be filled as below screenshot

![image](https://user-images.githubusercontent.com/26026302/209585867-348d8fe0-2829-4b70-8da9-cdb57c1f7e84.png)


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
