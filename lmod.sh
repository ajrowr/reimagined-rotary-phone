## Lmod is used for loading modules that are stored as gists, into a shell.
## eg. any shell functions that are useful on multiple machines can be
## made into a module, stored in the gist referenced by $LMOD_USER and
## $LMOD_LIBRARY, and then loaded by name with lmod. A general application of
## the technique to load a file from the web and source it in the context of
## the current shell, is in sourcescr().
## Note that this is not an executable shell script - due to the way shells work,
## it must either be source'd or its contents duplicated into a shell startup
## file, eg .profile
function sourcescr() {
    TMPF=$(mktemp /tmp/thing-XXXXX)
    curl -s $1 > $TMPF
    source $TMPF
    rm $TMPF
}
 
function sourcegist() {
    sourcescr https://gist.githubusercontent.com/${1}/raw/${2}
}
# eg: sourcegist ajrowr/b7de6268234ec6d908c6 filename.sh
 
function loadmodule() {
    sourcegist ${LMOD_USER}/${LMOD_LIBRARY} $1
}
alias lmod=loadmodule
