/** Types taken from AWS docs:
 *  https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html
 */

export interface LambdaProxyEvent {
  // Resource path
  resource?: string;

  // Path parameter
  path?: string;

  // Incoming request's method name
  httpMethod?: string;

  // String containing incoming request headers
  headers?: Record<string, string>;

  // List of strings containing incoming request headers
  multiValueHeaders?: Record<string, string[]>;

  // Query string parameters
  queryStringParameters?: Record<string, string>;

  // List of query string parameters
  multiValueQueryStringParameters?: Record<string, string[]>;

  // Path parameters
  pathParameters?: Record<string, string>;

  // Applicable stage variables
  stageVariables?: Record<string, string>;

  // Request context, including authorizer-returned key-value pairs
  requestContext?: Record<string, any>;

  // A JSON string of the request payload.
  body?: string;

  // A boolean flag to indicate if the applicable request payload is
  // Base64-encode
  isBase64Encoded?: boolean;
}

export interface LambdaProxyRealResponse {
  headers?: Record<string, string>;
  statusCode: number;
  body: any;
}

export type LambdaProxyResponse = Promise<LambdaProxyRealResponse | never>;

export interface LambdaSQSRecord {
  messageId: string;
  receiptHandle: string;
  body?: string;
  attributes: Record<string, string>;
  messageAttributes: Record<string, string>;
  md5OfBody: string;
  eventSource: string; // aws:sqs
  eventSourceARN: string;
  awsRegion: string;
}

export interface LambdaSQSEvent {
  Records: LambdaSQSRecord[];
}
