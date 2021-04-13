#!/bin/sh
is_int() {
  # usage: is_int "number"
  printf %d "$1" >/dev/null 2>&1
}

_parse_updown(){
  param=$1
  if [ "$param" = "mute" ]; then
    value="toggle"
  elif [ "$param" = "max" ]; then
    value="100"
    percent="%"
  elif [ "$param" = "min" ]; then
    value="0"
    percent="%"
  else
    value="$param"
    first="${value:0:1}"
    if [ "$first" = "-" ] || [ "$first" = "+" ]; then
      signal="$first"
      value="${value:1}"
    fi
    last="${value: -1}"
    if [ "$last" = "%" ]; then
      percent="%"
      value="${value::-1}"
    fi
    
    #[[ ! "$value" =~ ^[0-9]+$ ]] && value=""
    is_int $value || value=""
  fi
}

