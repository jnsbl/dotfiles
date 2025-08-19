#!/bin/sh

case ${MONS_NUMBER} in
  1)
      mons -o
      ;;
  2)
      mons -e top
      ;;
  *)
      # Handle it manually
      ;;
esac
