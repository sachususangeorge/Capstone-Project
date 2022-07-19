TERRAFORM_S3_TF_STATE_BUCKET=my-cancer-research-data-tfstate1234567
if aws s3 ls "s3://$TERRAFORM_S3_TF_STATE_BUCKET" 2>&1 | grep -q 'An error occurred'
then
    aws s3api create-bucket --bucket $TERRAFORM_S3_TF_STATE_BUCKET --region eu-central-1 --create-bucket-configuration LocationConstraint=eu-central-1
else
    echo "terraform bucket exist"
fi