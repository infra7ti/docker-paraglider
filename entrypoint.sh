#!/bin/bash

set -euo pipefail
exec 3>&1

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# -- Main ---------------------------------------------------------------------

# Check for failover shell
case ${1:-} in
  *bash  ) exec /bin/bash ;;
  *sh    ) exec /bin/sh ;;
  glide  ) exec /usr/local/bin/glide ${@:2} ;;
  glided ) exec /usr/local/bin/glided ${@:2} ;;
  *      ) echo "Unknown command: ${1}" && exit 1 ;;  
esac

exit 0
