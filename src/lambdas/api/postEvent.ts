import { LambdaProxyEvent, LambdaProxyResponse } from './lambda';

exports.handler = async (
  event: LambdaProxyEvent
): LambdaProxyResponse => {

  return {
    statusCode: 200,
    body: JSON.stringify({ message: 'Hello World' }),
    headers: {
      'Content-Type': 'application/json'
    }
  }
};
