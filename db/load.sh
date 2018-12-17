#!/bin/sh

BASE_DIR=$(dirname $(readlink -f "$0"))
if [ "$1" != "test" ]; then
    psql -h localhost -U farmayii -d farmayii < $BASE_DIR/farmayii.sql
fi
psql -h localhost -U farmayii -d farmayii_test < $BASE_DIR/farmayii.sql
