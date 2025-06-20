#!/bin/bash

OUTPUT_PATH="${1:-$CRAFT_PRIME/usr/share/rocks/output.txt}"
DPKG_ADMINDIR="${2:-CRAFT_PRIME/var/lib/dpkg}"

if [[ "$1" == "--help" ]]; then
  echo "Usage: $0 [output_path] [dpkg_admindir]"
  echo "  output_path: Optional. Path to the output file. Defaults to '$OUTPUT_PATH'."
  echo "  dpkg_admindir: Optional. Path to the dpkg admin directory. Defaults to '$DPKG_ADMINDIR'."
  exit 0
fi

mkdir -p "$(dirname "$OUTPUT_PATH")"

{
  echo "# os-release"
  cat /etc/os-release
  echo "# dpkg-query"
  dpkg-query --admindir="$DPKG_ADMINDIR" -f '${db:Status-Abbrev},${binary:Package},${Version},${source:Package},${Source:Version}\n' -W
} > "$OUTPUT_PATH"