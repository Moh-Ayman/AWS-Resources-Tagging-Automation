# AWS-Resources-Tagging-Automation
**Project scope:**
- To list all resources under AWS Services (Listed Below). And populate a lookup of all Resources with its coresponding ID or ARN &amp; its AWS Service. 

- And then to use manipulate Lookup to add Tags to it (Manually), where another script to loop on the tags and add it to all the mentioned resources. 

- All using AWS CLI.

**Features:**

1- Listing AWS Services Resources with metadata of (Resource ID & Resource Name)

2- Generating seperate Lookupfile per Service to add Tags to it

3- Automatedd Script to Creat Added Tags to Resources on AWS

**Repo Hierarchy:**

  1- DRY_RUN Dir used to validate Tagging Commands with extracted data from Lookup files.

      - Tagging_Script.sh: Used to loop on rows in lookup files, parse info within the lookup and print the command that will be used to create the tags for validation.

      - ec2_lookupfile: Dummy lookupfile used to simulate the tagging mechanism 

      - s3_lookupfile: Dummy lookupfile used to simulate the tagging mechanism

      - sg_lookupfile: Dummy lookupfile used to simulate the tagging mechanism

  2- RUN Dir contains latest live releases from scripts

      - List_PopulatLookup_Script.sh: Used to extract all resources & add it to lookups as per corresponding service. 

      - Tagging_Script.sh: Used to loop on rows in lookup files, parse info within the lookup and create the tags to the corressponding resource.  

**Usage Steps:**

  ##### To Run #####

  1- Go to DRY_RUN 

  2- Start Bash Script: [ Tagging_Script_TESTING_Ver.sh \< Lookup File Name \> ] (Mandatory Argument: Lookup File Name )

    Where it will loop on the Lookup line by line and run tagging command corresponding to the Service mentioned in the script.

    Command Example: Tagging_Script.sh ec2_lookupfile

  ##################
  
  ##### To Run #####

  1- Go to RUN 
  
  2- Start Bash Script: [ List_PopulatLookup_Script.sh ] (No Options/Arguments used)

    It will populate servuce's Lookups contains all resources within the current working directory.
    
    Lookup File will be created will follow naming convension : <AWS Service Name>_lookupfile Ex. ec2_lookupfile

  3 - Edit the Lookup file to add the resource Tag Key & Value Field's

    Tags Field will be used to populate tagging for these resources. 

    Tags Should be filled as below screenshot, its naming convention is [ Key=\<KeyName\>;Value=\<valueName\>|Key=\<KeyName\>;Value=\<valueName\>|... ]

    Remark: Key & Value words should be Capitalized as the above naming convension.

  ![image](https://user-images.githubusercontent.com/26026302/209599819-47214593-1577-4734-94d9-0078693820e6.png)
  
  3- Start Bash Script: [ Tagging_Script.sh \< Lookup File Name \> ] (Mandatory Argument: Lookup File Name )

    Where it will loop on the Lookup line by line and run tagging command corresponding to the Service mentioned in the script.

    Command Example: Tagging_Script.sh ec2_lookupfile

  ##################

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