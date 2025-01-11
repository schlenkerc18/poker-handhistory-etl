import boto3
import os

def lambda_handler(event, context):
    # Get the S3 bucket and object key from the event
    bucket_name = event['Records'][0]['s3']['bucket']['name']
    object_key = event['Records'][0]['s3']['object']['key']

    # Create an S3 client
    s3_client = boto3.client('s3')

    # Download the file from S3
    file_content = s3_client.get_object(Bucket=bucket_name, Key=object_key)['Body'].read().decode('utf-8')

    # Print the file contents (this will show up in CloudWatch logs)
    print(f"Contents of the file '{object_key}':\n{file_content}")

    return {
        'statusCode': 200,
        'body': f"File '{object_key}' processed successfully."
    }
