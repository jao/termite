__termitecomp (){
	local all c s=$'\n' IFS=' '$'\t'$'\n'
	local cur="${COMP_WORDS[COMP_CWORD]}"
	if [ $# -gt 2 ]; then
		cur="$3"
	fi
	for c in $1; do
		all="$all$c$4 $s"
	done
	IFS=$s
	COMPREPLY=($(compgen -P "$2" -W "$all" -- "$cur"))
	return
}

__termite_add (){
  __termitecomp "
start
stop
lunch
back
sick"
}

__termite_report (){
  __termitecomp "
daily
monthly
weekly"
}

__termite_edit_id (){
	local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=($(compgen -P "$2" -X "!" -- "$cur"))
	return
}

__termite_edit_date (){
  local ids=`work list --no-status --no-header | awk '{print $7;}'`
	local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=($(compgen -P "$2" -X "!" -- "$cur"))
	return
}

_termite (){
	local i c=1 command

	while [ $c -lt $COMP_CWORD ]; do
		i="${COMP_WORDS[c]}"
		command="$i";
		break ;
		c=$((++c))
	done

	if [ $c -eq $COMP_CWORD -a -z "$command" ]; then
		__termitecomp "
start
stop
lunch
back
sick
add
edit
update
report
help"
		return
	fi

  case "$command" in
  	add)        __termite_add ;;
#  	edit)       __termite_edit_id ;;
#  	edit*)      __termite_edit_date;;
  	report)     __termite_report ;;
  esac

}

complete -o default -o nospace -F _termite termite
