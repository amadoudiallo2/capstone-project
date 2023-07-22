const AWS = require('aws-sdk');
const sns = new AWS.SNS();

exports.handler = async (event) => {
  try {
    console.log("Lambda function triggered by S3 event:");
    console.log(JSON.stringify(event, null, 2));

    // Extract relevant information from the S3 event
    const { bucket, object } = event.Records[0].s3;
    const objectKey = decodeURIComponent(object.key);

    // Replace this with your SNS topic ARN
    const snsTopicArn = 'arn:aws:sns:us-east-1:123456789012:my-topic';

    // Compose the message to be sent to the SNS topic
    const message = `A new object '${objectKey}' was created in the bucket '${bucket.name}'.`;

    // Publish the message to the SNS topic
    const publishParams = {
      Message: message,
      TopicArn: snsTopicArn,
    };

    const publishResult = await sns.publish(publishParams).promise();
    console.log("Message published to SNS:", publishResult);

    return {
      statusCode: 200,
      body: "SNS message sent successfully!",
    };
  } catch (err) {
    console.error("Error sending SNS message:", err);
    return {
      statusCode: 500,
      body: "Error sending SNS message.",
    };
  }
};
