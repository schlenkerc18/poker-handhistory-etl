import json
import urllib.parse
import boto3

print('Loading function')
s3 = boto3.client('s3')


def lambda_handler(event, context):
    #print("Received event: " + json.dumps(event, indent=2))
    glue = boto3.client('glue')
    job_name = 'transform-hand-history'

    # Get the object from the event and show its content type
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')

    print("bucket:", bucket)
    print("key:", key)
    try:
        response = glue.start_job_run(
            JobName=job_name,
            Arguments={
                '--FILE_NAME': key
        }
        )

        return {
            'statusCode': 200,
            'body': f"Glue job started successfully: {response['JobRunId']}"
        }
    except Exception as e:
        print(e)
        print('Error getting object {} from bucket {}. Make sure they exist and your bucket is in the same region as this function.'.format(key, bucket))
        raise e
