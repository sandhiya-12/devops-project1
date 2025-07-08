## Connect to AWS Cloud

You must have an AWS account to proceed with the below steps.
1. Create an IAM programmatic user with administrator access
2. Create access key using IAM-> User-> select user -> Security credentails -> create Access key
3. Configure credentials
   ```sh
   aws configure
   ```
4. Test the connection
   ```sh
   aws s3 ls
   aws iam list-users
   ```
   