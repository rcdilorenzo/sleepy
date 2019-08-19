#!/bin/bash

yarn lambda-tools-build -o ./build src/lambdas/api/postEvent.ts

cd build

zip postEvent.zip postEvent.js postEvent.js.map
