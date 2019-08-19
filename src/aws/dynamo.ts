import AWS from './aws';

const endpoint = process.env.DYNAMODB_ENDPOINT ?
  process.env.DYNAMODB_ENDPOINT.replace('localstack', 'localhost') :
  undefined;

const ddb = new AWS.DynamoDB({
  apiVersion: '2012-08-10',
  endpoint
});

export const dbClient = new AWS.DynamoDB.DocumentClient({
  service: ddb
});

export default ddb;
