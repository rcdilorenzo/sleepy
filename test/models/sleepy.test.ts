import { v4 as uuidV4 } from 'uuid';
import sleepy, { SleepyParams } from '../../src/models/sleepy';

test('creating a record', async () => {
  const params: SleepyParams = {
    eventName: 'sleep_awake'
  };

  const row = await sleepy.putItem(params);
  expect(row.id).toBeDefined();
});

test('retrieving a record', async () => {
  const eventName = uuidV4();
  const { id, timestamp } = await sleepy.putItem({
    eventName
  });

  const row = await sleepy.getItem({ id, timestamp });
  expect(row!.eventName).toEqual(eventName);
})
