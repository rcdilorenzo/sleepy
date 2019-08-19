import { LambdaSQSEvent } from "./lambda";

exports.handler = async (
  event: LambdaSQSEvent
) => {
  console.log('received event:', event);
};
