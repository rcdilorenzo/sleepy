import * as AWS from 'aws-sdk';

AWS.config.update({ region: 'us-east-1' });

const endpoint = process.env.DYNAMODB_ENDPOINT ?
  process.env.DYNAMODB_ENDPOINT.replace('localstack', 'localhost') :
  undefined

const ddb = new AWS.DynamoDB({
  apiVersion: '2012-08-10',
  endpoint
});

export default ddb;
