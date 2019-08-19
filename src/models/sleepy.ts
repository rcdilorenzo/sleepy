import { v4 as uuidV4 } from 'uuid';
import { dbClient } from '../aws/dynamo';

const TABLE_NAME = 'sleep';

export interface SleepyID {
  id: string;
  timestamp: number;
}

export interface SleepyParams {
  eventName: string;
};

export interface SleepyRow extends SleepyID, SleepyParams {
};

const putItem = (params: SleepyParams): Promise<SleepyRow> => {
  const data = {
    ...params,
    id: uuidV4(),
    timestamp: Date.now()
  };

  return dbClient
    .put({ TableName: TABLE_NAME, Item: data })
    .promise()
    .then(() => data);
 };

const getItem = async (params: SleepyID): Promise<SleepyRow | undefined> => (
  dbClient
    .get({ TableName: TABLE_NAME, Key: params })
    .promise()
    .then(r => r.Item as SleepyRow)
);

const sleepy = {
  putItem,
  getItem
};

export default sleepy;
