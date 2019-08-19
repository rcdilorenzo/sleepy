import AWS from './aws';

const endpoint = process.env.SQS_ENDPOINT ?
  process.env.SQS_ENDPOINT.replace('localstack', 'localhost') :
  undefined;

const sqs = new AWS.SQS({ apiVersion: '2012-11-05', endpoint });

export default sqs;
