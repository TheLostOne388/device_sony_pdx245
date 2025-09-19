#!/bin/bash
# Minimal stub for apex-ls expected by apex sepolicy tests.
# Lists APEX package contents by deferring to deapexer if available,
# otherwise prints the APEX file path.

DEAPEXER=$(dirname "$0")/deapexer
if [ -x "$DEAPEXER" ]; then
    "$DEAPEXER" list "$@"
else
    for f in "$@"; do
        echo "APEX: $f (stub)"
    done
fi
