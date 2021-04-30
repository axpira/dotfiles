#/usr/bin/env bash
# Consulta os tickets do Jira na fila Pay (ID: 106)
# mostra uma lista com os tickets e ao selecionar algum
# abre o browser com o ticket aberto
#
# Como utilizar:
#   Antes de utilizar precisa criar um token no Jira: 
#       https://id.atlassian.com/manage-profile/security/api-tokens
#   Exportar as variaveis de ambiente:
#       JIRA_USER: com seu usuario do Jira (email Bexs)
#       JIRA_TOKEN: com o token criado no passo anterior
#     *para ficar permanente colocar no $HOME/.profile
#         export JIRA_USER="seu user"
#         export JIRA_TOKEN="seu token"
#   Copiar o script para o ~/.local/bin (ou algum diretório que esteja no $PATH)
#   Executar o script:
#   $ tickets.sh
#
#   Para facilitar pode criar uma tecla de atalho para a execução
#
# Dependencias:
#   $ sudo apt install curl jq dmenu
#
#   curl:  para fazer a chamada ao Jira
#   jq:    para filtrar o json de retorno
#   dmenu: para abrir o menu
#
#

QUEUE=106
BROWSER=${BROWSER:-firefox}

notify() {
    notify-send -a ticket -u $1 -t $2 "Tickets" "$3"
}


notify normal 2000 "Searching for tickets"

jira_response_file=$(mktemp)
http_code=$(curl -u $JIRA_USER:$JIRA_TOKEN \
    -o $jira_response_file \
    -s \
    -H "accept: application/json" \
    $JIRA_URL/rest/servicedeskapi/servicedesk/CS/queue/$QUEUE/issue \
    -w "%{http_code}" \
    --silent \
)

jira_response=$(cat $jira_response_file)
rm $jira_response_file

if [ $http_code -ne 200 ]; then
    notify critical 10000 "Error $http_code\n$(echo $jira_response | jq .)"
    exit 1
fi

selected=$(echo $jira_response \
    | jq -r '.values | sort_by(.fields.issuetype.name,.fields.status.name) | .[] | [.key,.fields.issuetype.name,.fields.status.name,.fields.summary,.fields.assignee.displayName] | @csv' \
    | column -t -s "," \
    | tr -d '"' \
    | dmenu -p "TICKETS: " -l 50 -i -nf "#ffffff")

if [ -z "$selected" ]; then
    notify-send normal 2000 "canceled"
    exit 2
fi

id=$(echo $selected | cut -d" " -f1)
$BROWSER $JIRA_URL/browse/$id
