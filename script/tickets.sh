#/usr/bin/env bash

#| jq -r '.values | sort_by(.fields.issuetype.name,.fields.status.name) | .[] | (.key+" | "+.fields.issuetype.name+" | "+.fields.status.name+" | "+.fields.summary)' \
#| jq -r '.values | sort_by(.fields.issuetype.name,.fields.status.name) | .[] | [.key,.fields.issuetype.name,.fields.status.name,.fields.summary] | @csv' \
notify-send -t 100 "Searching for tickets"
res=$(curl -u $JIRA_USER:$JIRA_TOKEN \
    -s \
    -H "accept: application/json" \
    $JIRA_URL/rest/servicedeskapi/servicedesk/CS/queue/106/issue \
    | jq -r '.values | sort_by(.fields.issuetype.name,.fields.status.name) | .[] | [.key,.fields.issuetype.name,.fields.status.name,.fields.summary,.fields.assignee.displayName] | @csv' \
    | column -t -s "," \
    | tr -d '"' \
    | dmenu -p "TICKETS: " -l 50 -i)

[ -z $res ] && exit 1
id=$(echo $res | cut -d" " -f1)
firefox $JIRA_URL/browse/$id
