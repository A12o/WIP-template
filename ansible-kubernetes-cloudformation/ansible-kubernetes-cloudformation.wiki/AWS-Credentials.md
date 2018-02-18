## Credentials
### Amazon AWS Credentials
AWS EC2 and CloudFormation require credentials and a private key, here are the 5 pieces of information required to proceed.

Step 1:
* AWS_ACCESS_KEY_ID & AWS_SECRET_ACCESS_KEY: see [here](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSGettingStartedGuide/AWSCredentials.html) for information on how to retrieve this.

* AWS_REGION: see [here](http://docs.aws.amazon.com/general/latest/gr/rande.html) for information on how to retrieve this

* ASW_KEYPAIR: see [here](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html) from information on how to create a keypair, all that is required is the name of the keypair you would like to use.

```
export AWS_ACCESS_KEY_ID=[MY-ACCESS-KEY]
export AWS_SECRET_ACCESS_KEY=[MY-SECRET-KEY]
export AWS_REGION=[MY-AWS-REGION]
export AWS_KEYPAIR=[MY-AWS-KEYPAIR]
```

Step 2:

* AWS_KMS_KEY: see [here](http://docs.aws.amazon.com/kms/latest/developerguide/overview.html) for information on how to retrieve this, or after setting up the access_key_id, secret_access_key, keypair and region variables, you can use the following commands to generate a new KMS key, listed as "Arn" in the example return below:

If you already have a KMS key ARN previously created, or created using the link above:
```
export AWS_KMS_KEY=[MY-AWS-KEY]
```

If you need to generate a new KMS key use the following:
```
aws kms --region=$AWS_REGION create-key --description="kube-aws assets"
export AWS_KMS_KEY=[MY-AWS-KEY (this is the Arn value from the command above)]
aws kms create-alias --alias-name alias/kube-aws --target-key-id $AWS_KMS_KEY
```
```
#Results
{
    "KeyMetadata": {
        "CreationDate": 1458235139.724,
        "KeyState": "Enabled",
        "Arn": "arn:aws:kms:us-west-1:xxxxxxxxx:key/xxxxxxxxxxxxxxxxxxx",
        "AWSAccountId": "xxxxxxxxxxxxx",
        "Enabled": true,
        "KeyUsage": "ENCRYPT_DECRYPT",
        "KeyId": "xxxxxxxxx",
        "Description": "kube-aws assets"
    }
}
```