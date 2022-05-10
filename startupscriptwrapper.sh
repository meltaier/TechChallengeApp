#!/bin/sh

echo 'Deploying tasks in postgres DB'
./TechChallengeApp updatedb -s

echo 'Start http server'
./TechChallengeApp serve

