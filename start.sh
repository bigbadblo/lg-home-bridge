#!/bin/bash

cd /app/slack-bot  && git stash && git pull && bundle

node index.js alexa &

cd /app/slack-bot && bundle exec rackup config.ru &>  /app/slack-bot/log.txt &

while sleep 60; do
  ps aux |grep rackup |grep -q -v grep
  PROCESS_1_STATUS=$?
  ps aux |grep node |grep -q -v grep
  PROCESS_2_STATUS=$?node index.js alexa
  # If the greps above find anything, they exit with 0 status
  # If they are not both 0, then something is wrong
  if [ $PROCESS_1_STATUS -ne 0 -o $PROCESS_2_STATUS -ne 0 ]; then
    echo "One of the processes has already exited."
    exit 1
  fi
done

