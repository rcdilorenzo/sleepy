import { v4 as uuidV4 } from 'uuid';
import { dbClient } from '../aws/dynamo';

const TableName = 'sleep';

export interface SleepyID {
  id: string;
}

export interface SleepyParams {
  eventName: string;
  timestamp: number;
};

export interface SleepyRow extends SleepyID, SleepyParams {
};

const all = (): Promise<SleepyRow[]> => {
  return dbClient
    .scan({ TableName })
    .promise()
    .then(r => (r.Items || []) as SleepyRow[])
};

const putItem = (params: SleepyParams): Promise<SleepyRow> => {
  const data = {
    ...params,
    id: uuidV4()
  };

  return dbClient
    .put({ TableName, Item: data })
    .promise()
    .then(() => data);
 };

const getItem = async (
  params: Partial<SleepyID>
): Promise<SleepyRow | undefined> => (
  dbClient
    .get({ TableName, Key: params })
    .promise()
    .then(r => r.Item as SleepyRow)
);

const sleepy = {
  putItem,
  getItem,
  all
};

export default sleepy;
