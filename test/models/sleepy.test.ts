import { v4 as uuidV4 } from 'uuid';
import sleepy, { SleepyParams } from '../../src/models/sleepy';

test('creating a record', async () => {
  const params: SleepyParams = {
    eventName: 'sleep_awake',
    timestamp: Date.now()
  };

  const row = await sleepy.putItem(params);
  expect(row.id).toBeDefined();
});

test('retrieving a record', async () => {
  const eventName = uuidV4();
  const { id } = await sleepy.putItem({
    eventName,
    timestamp: Date.now()
  });

  const row = await sleepy.getItem({ id });
  expect(row!.eventName).toEqual(eventName);
});

test('getting all records', async () => {
  await sleepy.putItem({
    eventName: 'test',
    timestamp: Date.now()
  })

  const rows = await sleepy.all();
  console.log(rows);
  expect(rows).toBeDefined();
  expect(rows.length).toBeGreaterThan(0);
});
