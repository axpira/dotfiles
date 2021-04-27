#/usr/bin/env bash

. ~/.env

notify-send -t 100 "Searching for issues"
res=$(curl -u $JIRA_USER:$JIRA_TOKEN \
    -s \
    -H "accept: application/json" \
    $JIRA_URL/rest/servicedeskapi/servicedesk/CS/queue/106/issue \
    | jq -r '.values[] | (.key+" | "+.fields.status.name+" | "+.fields.summary)' \
    | dmenu -p "ISSUE: " -l 50 -i)

[ -z $res ] && exit 1
id=$(echo $res | cut -d"|" -f1)
firefox $JIRA_URL/browse/$id
