#!/bin/bash

set -e

ARCHIVE_FILE=$1

DESTINATION_PATH=$2

# Only run cp if the file exists, to reduce noise in the postgres logs.
if [ -e "$ARCHIVE_FILE" ]; then
    # The exit status is important, so this *must* be the last command executed
    # in the script.
    cp "$ARCHIVE_FILE" "$DESTINATION_PATH"
else
    # "The command will be asked for file names that are not present in the
    # archive; it must return nonzero when so asked."
    # https://www.postgresql.org/docs/10/static/archive-recovery-settings.html
    exit 1
fi
