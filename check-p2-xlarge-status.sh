#! /bin/bash
while true; do
  STATE="$(aws ec2 describe-instances --filters Name=instance-type,Values=p2.xlarge --query Reservations[0].Instances[0].State.Name)"
  if [ "$STATE" = '"running"' ]; then
    COMMAND='display notification '$STATE' with title "p2.xlarge status"'
    osascript -e "$COMMAND"
    sleep 300
  fi
done
