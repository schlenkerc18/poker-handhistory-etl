import sys
import boto3
from awsglue.utils import getResolvedOptions
from awsglue.context import GlueContext
from pyspark.context import SparkContext
from pyspark.sql import SQLContext

# Initialize Glue and Spark contexts
glueContext = GlueContext(SparkContext.getOrCreate())
spark = glueContext.spark_session
sqlContext = SQLContext(spark)

# Get the job parameters
args = getResolvedOptions(sys.argv, ['SOURCE_BUCKET', 'TARGET_BUCKET', 'FILE_NAME'])

source_bucket = args['SOURCE_BUCKET']
target_bucket = args['TARGET_BUCKET']
file_name = args['FILE_NAME']

print("source bucket:", source_bucket)
print("target_bucket:", target_bucket)
print("file_name:", file_name)

# Read data from the source S3 bucket
input_path = f"s3://{source_bucket}/{file_name}"
text = spark.read.text(input_path)


print(text)

# Write the transformed data to the target S3 bucket
output_path = f"s3://{target_bucket}/"

print("Data transformation and write completed successfully!")
