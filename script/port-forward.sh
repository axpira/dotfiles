#!/bin/bash

WINDOW_NAME="port-forward"
tmux rename-window "$WINDOW_NAME"
tmux split-window -h
tmux split-window -h
tmux select-pane -L
tmux split-window -v
tmux split-window -v
tmux split-window -v

tmux select-pane -R
tmux split-window -v
tmux split-window -v
tmux split-window -v
tmux split-window -v

tmux select-pane -R
tmux split-window -v
tmux split-window -v

tmux select-layout tiled

rules=(
 "payment;token;6565"
 "services;simulator;6569"
 "backservice;merchant;6567"
 "backservice;consumer;6568"
 "services;simulator;8090:8080"
 "payment;sale;6571"
 "payment;balance;6599"
 "payment;anticipation;6444"
 "services;tax;6572"
)

i=0
for rule in "${rules[@]}"; do
	IFS=$'\n' read -d "" -ra arr <<< "${rule//;/$'\n'}"
	namespace="${arr[0]}"
	service="${arr[1]}"
	port="${arr[2]}"
	tmux send-keys -t $WINDOW_NAME.$i "kubectl -n $namespace port-forward svc/$service $port" C-m
	i=$((i + 1))
done

tmux send-keys -t $WINDOW_NAME.$i "kubectl port-forward --namespace services $(kubectl get pod --namespace services --selector='app=authentication' --output jsonpath='{.items[0].metadata.name}') 8099:8080"
