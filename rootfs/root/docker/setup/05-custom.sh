#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202511291200-git
# @@Author           :  CasjaysDev
# @@Contact          :  CasjaysDev <docker-admin@casjaysdev.pro>
# @@License          :  MIT
# @@ReadME           :
# @@Copyright        :  Copyright 2023 CasjaysDev
# @@Created          :  Mon Aug 28 06:48:42 PM EDT 2023
# @@File             :  05-custom.sh
# @@Description      :  script to install Jekyll with GitHub Pages support
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# shellcheck shell=bash
# shellcheck disable=SC2016
# shellcheck disable=SC2031
# shellcheck disable=SC2120
# shellcheck disable=SC2155
# shellcheck disable=SC2199
# shellcheck disable=SC2317
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Set bash options
set -o pipefail
[ "$DEBUGGER" = "on" ] && echo "Enabling debugging" && set -x$DEBUGGER_OPTIONS
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Set env variables
exitCode=0
LANG_VERSION="${LANG_VERSION:-latest}"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Predefined actions
echo "Installing Jekyll with GitHub Pages support"

# Install Jekyll and GitHub Pages dependencies
if [ "$LANG_VERSION" = "latest" ]; then
  echo "Installing latest Jekyll with github-pages gem..."
  gem install jekyll bundler github-pages webrick || exitCode=1
else
  echo "Installing Jekyll version ${LANG_VERSION}..."
  gem install jekyll:${LANG_VERSION} bundler github-pages webrick || exitCode=1
fi

# Verify installation
if command -v jekyll >/dev/null 2>&1; then
  echo "Jekyll installed successfully"
  jekyll --version || exitCode=1
  echo "Installed gems:"
  gem list | grep -E "(jekyll|github-pages|bundler)" || true
else
  echo "Jekyll installation failed" >&2
  exitCode=1
fi

# Create default site directory
mkdir -p /srv/jekyll || exitCode=1
chown -R root:root /srv/jekyll || true

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Set the exit code
exit $exitCode
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# ex: ts=2 sw=2 et filetype=sh
