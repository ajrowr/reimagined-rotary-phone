function windowtitle() { export PS1="${PS1}\[\e]2;${1}\a"; }
function tabtitle() { export PS1="${PS1}\[\e]1;${1}\a"; }

function settermcolours {
    setterm -background $1 -foreground $2 -powersave off -blank 0 -powerdown 0 -store -clear
}

function pi {
    if test -n "$1"; then workon $1; fi
    if test -e console.py; then python -i ./console.py; else python manage.py shell; fi
}
complete -o default -o nospace -F _virtualenvs pi

function startservice () {
	COLOR_SCHEME='30;47'
	source ~/project/${1}/service.cfg
	setterm -powersave off -powerdown 0 -blank 0 -store 
	workon ${1}
	T='          '
	printf "\e[2J\e[${COLOR_SCHEME}m\e[H  %-70s %70s$T$T$T$T$T$T$T$T$T \e[0K\e[2;r\e[0m\n\e[2K" ${1} "port $DEV_PORT"
	printf "\e[2J\e[${COLOR_SCHEME}m\e[H%$(tput cols)s\r\e[H%s \e[2;r\e[0m\n" "port ${DEV_PORT}" ${1}
	./manage.py runserver 0.0.0.0:$DEV_PORT
}

export REXEC_HOST="alan@glacier.io.codex.cx"
## Execute command remotely, helps if you have ssh keys setup
function rexec () {
    ssh $REXEC_HOST $@ ;
}

