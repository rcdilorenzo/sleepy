process.env.DYNAMODB_ENDPOINT =
  process.env.DYNAMODB_ENDPOINT || 'http://localhost:4569';

process.env.SQS_ENDPOINT =
  process.env.SQS_ENDPOINT || 'http://localhost:4576';

module.exports = () => {
  // nothing right now
};
