#!/bin/bash

yarn lambda-tools-build -o ./build src/lambdas/api/postEvent.ts
yarn lambda-tools-build -o ./build src/lambdas/api/handleJob.ts

cd build

zip postEvent.zip postEvent.js postEvent.js.map
zip handleJob.zip handleJob.js handleJob.js.map
