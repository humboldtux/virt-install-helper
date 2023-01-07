#!/usr/bin/env bash

# This script is a virt-install helper. # It prompts user for
# the most common options to create and launch a vm.
#
# By default file explorer opens ~/Documents to search for
# a iso file. You can use ISODIR variable at the command line
# to choose a different directory, e.g.:
#
# ISODIR="/tmp" ./virtinstall-helper.sh

set -euo pipefail

ISODIR=${ISODIR:-${HOME}/Documents}

gum style \
  --foreground 99 \
  --border double \
  --border-foreground 99 \
  --padding "1 2" \
  --margin 1 "virt-install Helper"

sleep 1
clear

NAME=$(gum input --prompt "VM Name: " --placeholder "" \
  | tr -d '[:space:][:blank:]')
clear

OS=$(osinfo-query --fields=short-id os \
  | tail -n +3 \
  | gum filter --placeholder="Choose OS" \
  | tr -d '[:space:][:blank:]')
clear

echo "Number of vcpus: "
VCPUS=$(seq 1 6 | gum choose)
clear

echo "Memory:"
MEM=$(gum choose --selected=1024 256 512 1024 2048 4096)
clear

echo "SIZE (Go): "
SIZE=$(gum choose --selected=10 5 10 20 30)
clear

ISO=$(gum file "$ISODIR")

display_variable() {
  echo "$(gum style --foreground 99 "$1:")" "$2"
}

display_variable NAME "$NAME"
display_variable VCPUS "$VCPUS"
display_variable MEM "$MEM"
display_variable SIZE "$SIZE"
display_variable ISO "$ISO"

echo ""
gum confirm "Create and Launch VM?" || exit

gum spin --title "Creating and launching VM in virt-viewer..." -- virt-install \
  --name="$NAME" \
  --os-variant="$OS" \
  --vcpus="$VCPUS" \
  --memory="$MEM" \
  --disk size="$SIZE" \
  --cdrom="$ISO"
