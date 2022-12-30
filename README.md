# AWS-Resources-Tagging-Automation
**Project scope:**
- To list all resources under AWS Services (Listed Below). And populate a lookup of all Resources with its coresponding ID or ARN &amp; its AWS Service. 

- And then to use manipulate Lookup to add Tags to it (Manually), where another script to loop on the tags and add it to all the mentioned resources. 

- All using AWS CLI.

**Features:**

1- Listing AWS Services Resources with metadata of (Resource ID & Resource Name)

2- Generating seperate Lookupfile per Service to add Tags to it

3- Automated Script to Create Added Tags to Resources on AWS

**Repo Hierarchy:**

  1- DRY_RUN Dir used to validate Tagging Commands with extracted data from Lookup files.

      - list_resources_DR.sh: Used to extract all resources & add it to lookups as per corresponding service. 

      - build_lookup_DR.sh: Used to auto populate dummy tags to (ec2, security groups, vpc) services lookup

        (ec2_dummy_lookupfile, sg_dummy_lookupfile & vpc_dummy_lookupfile) will be populated.

      - tag_resources_DR.sh: Used to loop on rows in lookup files, parse info within the lookup and print the command that will be used to create the tags for validation.

  2- RUN Dir contains latest live releases from scripts

      - list_resources_R.sh: Used to extract all resources & add it to lookups as per corresponding service. 

      - tag_resources_R.sh: Used to loop on rows in lookup files, parse info within the lookup and create the tags to the corressponding resource.  

**How to use:**

  ##### DRY RUN #####

  1- Go to DRY_RUN 

  2- Start Bash Script: [ list_resources_R.sh ] (No Options/Arguments used)

  - It will populate servuce's Lookups contains all resources within the current working directory.
  
  - Lookup File will be created will follow naming convension : <AWS Service Name>_lookupfile Ex. ec2_lookupfile

  3- Start Bash Script: [ build_lookup_DR.sh ] (No  Options/Arguments used)
  
  - It will populate dummy tags automatically into (ec2, security groups, vpc) services lookup file (ec2_dummy_lookupfile, sg_dummy_lookupfile & vpc_dummy_lookupfile).

  4- Start Bash Script: [ tag_resources_DR.sh \< Lookup File Name \> ] (Mandatory Argument: Dummy Lookup File Name )

    - Where it will loop on the Lookup line by line and echo tagging command corresponding to the Service mentioned in the script.

    - Command Example: tag_resources_DR.sh ec2_lookupfile

  ##################
  
  ##### Run #####

  1- Go to RUN 
  
  2- Start Bash Script: [ list_resources_R.sh ] (No Options/Arguments used)

    - It will populate servuce's Lookups contains all resources within the current working directory.
    
    - Lookup File will be created will follow naming convension : <AWS Service Name>_lookupfile Ex. ec2_lookupfile

  3 - Edit the Lookup file to add the resource Tag Key & Value Field's

    - Tags Field will be used to populate tagging for these resources. 

    - Tags naming convention Should be filled as below screenshot 
      
      [ Key=<KeyName>;Value=<valueName>|Key=<KeyName>;Value=<valueName>|... ]

    - Remark: Key & Value words should be Capitalized as the above naming convension.

  ![image](https://user-images.githubusercontent.com/26026302/209599819-47214593-1577-4734-94d9-0078693820e6.png)
  
  4- Start Bash Script: [ tag_resources_R.sh \< Lookup File Name \> ] (Mandatory Argument: Lookup File Name )

    - Where it will loop on the Lookup line by line and run tagging command corresponding to the Service mentioned in the script.

    - Command Example: tag_resources_R.sh ec2_lookupfile

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
