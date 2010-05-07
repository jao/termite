__workcomp ()
{
	local all c s=$'\n' IFS=' '$'\t'$'\n'
	local cur="${COMP_WORDS[COMP_CWORD]}"
	if [ $# -gt 2 ]; then
		cur="$3"
	fi
	for c in $1; do
		case "$c$4" in
		*)     all="$all$c$4 $s" ;;
		esac
	done
	IFS=$s
	COMPREPLY=($(compgen -P "$2" -W "$all" -- "$cur"))
	return
}

__work_add () {
  __workcomp "
start
stop
lunch
back
sick
"
}

__work_report(){
  __workcomp "
daily
monthly
weekly"
}

_work ()
{
	local i c=1 command

	while [ $c -lt $COMP_CWORD ]; do
		i="${COMP_WORDS[c]}"
		command="$i";
		break ;
		c=$((++c))
	done

	if [ $c -eq $COMP_CWORD -a -z "$command" ]; then
		case "${COMP_WORDS[COMP_CWORD]}" in
		*)    __workcomp "
start
stop
lunch
back
sick
add
edit
update
report
help" ;;
		esac
		return
	fi

  case "$command" in
  	add)        __work_add ;;
  	report)     __work_report ;;
  esac

}

complete -o default -o nospace -F _work work
