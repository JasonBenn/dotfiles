#! /bin/bash
while true; do
  STATE="$(aws ec2 describe-instances --filters "Name=instance-type,Values=p2.xlarge" | grep STATE | grep -v STATEREASON  | awk '{ print $3 }')"
  osascript -e 'display notification "'${STATE}'" with title "p2.xlarge status"'
  sleep 600
done
