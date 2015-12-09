#!/usr/bin/env bash

rm -rf build
mkdir build
tar czf build/notebook.tar.gz notebook
tar czf build/notebook-deps.tar.gz notebook-deps
cp marathon/deploy-zeppelin.sh build/
cp conf/interpreter.json build/
cp conf/zeppelin-env.sh build/
