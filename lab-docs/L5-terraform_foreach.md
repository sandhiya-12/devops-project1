# for_each in terraform 

To create multiple EC2 instances in a single file we can use for_each 

we can added below code snippet to the existing terraform file to create 3 instances as per our requirement. 

```sh 
for_each = toset(["master", "slave"])
   tags = {
     Name = "${each.key}"
   }
```

Add 3 instances for jenkins-master, jenkins-slave, ansible

after this [terraform v4 file]() looks like this terraform\V3-EC2-with-VPC-foreach.tf