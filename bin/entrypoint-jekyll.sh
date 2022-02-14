#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202202020147-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.com
# @License       : WTFPL
# @ReadME        : docker-entrypoint --help
# @Copyright     : Copyright: (c) 2022 Jason Hempstead, Casjays Developments
# @Created       : Wednesday, Feb 02, 2022 01:47 EST
# @File          : docker-entrypoint
# @Description   :
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
APPNAME="$(basename "$0")"
VERSION="202202020147-git"
USER="${SUDO_USER:-${USER}}"
HOME="${USER_HOME:-${HOME}}"
SRC_DIR="${BASH_SOURCE%/*}"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Set bash options
if [[ "$1" == "--debug" ]]; then shift 1 && set -xo pipefail && export SCRIPT_OPTS="--debug" && export _DEBUG="on"; fi
trap 'exitCode=${exitCode:-$?};[ -n "$DOCKER_ENTRYPOINT_TEMP_FILE" ] && [ -f "$DOCKER_ENTRYPOINT_TEMP_FILE" ] && rm -Rf "$DOCKER_ENTRYPOINT_TEMP_FILE" &>/dev/null' EXIT

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
SITEDIR="${SITEDIR:-/data/htdocs}"
HOSTADMIN="${HOSTADMIN:-admin@localhost}"
CONFIG="${CONFIG:-/config/init.sh}"

export TZ="${TZ:-America/New_York}"
export HOSTNAME="${HOSTNAME:-casjaysdev-jekyll}"

[ -n "${TZ}" ] && echo "${TZ}" >/etc/timezone
[ -n "${HOSTNAME}" ] && echo "${HOSTNAME}" >/etc/hostname
[ -n "${HOSTNAME}" ] && echo "127.0.0.1 $HOSTNAME localhost" >/etc/hosts
[ -f "/usr/share/zoneinfo/${TZ}" ] && ln -sf "/usr/share/zoneinfo/${TZ}" "/etc/localtime"

case $1 in
healthcheck)
  if curl -q -LSsfI "http://localhost:4000" 2>/dev/null | grep 'HTTP/*.' | grep -q '^'; then
    echo "OK"
    exit 0
  else
    echo "FAIL"
    exit 10
  fi
  ;;
bash | sh | shell)
  shift 1
  [ $# -eq 0 ] && exec bash -l || exec bash "$@"
  ;;

build)
  shift 1
  bundle exec jekyll build
  ;;

*)
  if [ ! -f "$SITEDIR/.nojekyll" ] || [ ! -f "$SITEDIR/Gemfile" ] || [ ! -f "$SITEDIR/_config.yml" ]; then
    echo "NOTE: hmm, I don't see a Gemfile so I don't think there's a jekyll site here"
    echo "Either you didn't mount a volume, or you mounted it incorrectly."
    echo "Be sure you're in your jekyll site root and use something like this to launch"
    echo ""
    echo "Also, if $CONFIG exists it will be sourced"
    echo "docker run --name jekyll --rm -p 4000:4000 -v \$PWD:/$SITEDIR -v \$PWD/init.sh:$CONFIG casjay/jekyll"
    exit 1
  else
    mkdir -p "$SITEDIR" && cd "$SITEDIR" || exit 1
    if [ ! -f "$SITEDIR/.nojekyll" ]; then
      bundle install --retry 5 --jobs 20
    fi
    [ -f "$CONFIG" ] && . "$CONFIG"
    bundle exec jekyll serve --force_polling -H 0.0.0.0 -P 4000
  fi
  ;;
esac
