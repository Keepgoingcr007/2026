aws dynamodb create-table `
    --table-name my-lock-table-1001 `
    --attribute-definitions AttributeName=LockID,AttributeType=S `
    --key-schema AttributeName=LockID,KeyType=HASH `
    --billing-mode PAY_PER_REQUEST `
    --region us-east-1


    //above is dynamodb command : for state lockin

    //also we need to already/prerequisite create a s3 backend bucket 


    ////////////////////////2 changes are must ///////////////////////////////////////////////////////////
