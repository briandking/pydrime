#!/bin/sh
set -e

MODE="${PYDRIME_SERVER_MODE:-s3}"
LISTEN="${PYDRIME_LISTEN:-:8000}"
WORKSPACE="${PYDRIME_WORKSPACE:-}"

case "$MODE" in
s3)
    exec pydrime server s3 \
        --listen "$LISTEN" \
        ${WORKSPACE:+--workspace "$WORKSPACE"} \
        "$@"
    ;;
restic)
    exec pydrime server restic \
        --listen "$LISTEN" \
        ${WORKSPACE:+--workspace "$WORKSPACE"} \
        "$@"
    ;;
webdav)
    case "$LISTEN" in
    *:*) HOST="${LISTEN%:*}" PORT="${LISTEN##*:}" ;;
    *) HOST="0.0.0.0" PORT="$LISTEN" ;;
    esac
    [ -z "$HOST" ] && HOST="0.0.0.0"
    exec pydrime server webdav \
        --host "$HOST" --port "$PORT" \
        ${WORKSPACE:+--workspace "$WORKSPACE"} \
        "$@"
    ;;
*)
    echo "Unknown PYDRIME_SERVER_MODE: $MODE (use: s3, restic, webdav)" >&2
    exit 1
    ;;
esac
