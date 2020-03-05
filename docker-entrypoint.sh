#!/bin/sh -e
# Magical Entrypoint
# Brian Dwyer - Broadridge Financial Solutions

# Kitchen Wrapper & Passthrough
case "$1" in
	init ) sam "$@";;
	validate ) sam "$@";;
	build ) sam "$@";;
	local ) sam "$@";;
	package ) sam "$@";;
	deploy ) sam "$@";;
	logs ) sam "$@";;
	publish ) sam "$@";;
	* )	exec "$@";;
esac
