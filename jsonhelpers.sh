
# Source this file.
# It contains helpers for dealing with JSON. Will probably move to Lmod

## Remap and Loadmap, used in combination, export the JSON values obtained from a resource into the shell environ
function remap () {
    python -c 'import sys, json;inp=sys.stdin.read();d = json.loads(inp);print "\n".join(["export _{}=\"{}\"".format(k,v) for k,v in d.items()])' > /tmp/REMAP_TMP
}
alias loadmap="cat /tmp/REMAP_TMP;source /tmp/REMAP_TMP"
## eg: $ curl http://jsonresource/ | remap;loadmap

## Demap dumps the named vars from the shell environ as a json string.
## Removes _ prefix from var name.
function demap () {
    python -c "import json,os,sys;names=sys.argv[sys.argv.index('-')+1:];print json.dumps(dict([(k.lstrip('_'),os.environ[k]) for k in names]))" - $@
}
## eg: $ export username=alan;curl http://jsonresource/ -H 'Content-Type: application/json' -d "`demap username`"

function authtoken {
    printf "Authorization: Token token=${1}"
}

function ctjson {
    printf "Content-Type: application/json"
}


