import ddb from '../src/aws/dynamo';

test('reading a table', async () => {
  const params = { TableName: 'sleep' };
  const result = await ddb
    .describeTable(params)
    .promise();

  expect(result.Table!.TableName).toEqual('sleep');
});
