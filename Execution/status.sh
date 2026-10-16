#!/bin/bash
# Usage: status.sh [project]   (run in Runs/<queue>/)
# Counts tasks per ht.* state dir, only those of project if given.
PROJECT="$1"

for DIR in ht.*; do
    [ -d "$DIR" ] || continue
    case "$DIR" in ht.tmp.*) continue;; esac
    if [ -n "$PROJECT" ]; then
        # ht.waitstart has a priority level before the project, the other state dirs don't
        COUNT=$(find "$DIR/$PROJECT" "$DIR"/[1-5]/"$PROJECT" -name "ht.task.*" -prune 2>/dev/null | wc -l)
    else
        COUNT=$(find "$DIR" -name "ht.task.*" | wc -l)
    fi
    echo "$DIR : $COUNT"
done
