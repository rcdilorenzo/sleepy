import sqs from '../src/aws/sqs';

test('getting a queue', async () => {
  const result = await sqs.listQueues({ QueueNamePrefix: 'job' }).promise();

  expect(result.QueueUrls).toEqual([
    'http://localstack:4576/queue/job_queue',
    'http://localstack:4576/queue/job_queue_deadletter'
  ]);
});
