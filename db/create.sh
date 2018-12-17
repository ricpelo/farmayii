#!/bin/sh

if [ "$1" = "travis" ]; then
    psql -U postgres -c "CREATE DATABASE farmayii_test;"
    psql -U postgres -c "CREATE USER farmayii PASSWORD 'farmayii' SUPERUSER;"
else
    sudo -u postgres dropdb --if-exists farmayii
    sudo -u postgres dropdb --if-exists farmayii_test
    sudo -u postgres dropuser --if-exists farmayii
    sudo -u postgres psql -c "CREATE USER farmayii PASSWORD 'farmayii' SUPERUSER;"
    sudo -u postgres createdb -O farmayii farmayii
    sudo -u postgres psql -d farmayii -c "CREATE EXTENSION pgcrypto;" 2>/dev/null
    sudo -u postgres createdb -O farmayii farmayii_test
    sudo -u postgres psql -d farmayii_test -c "CREATE EXTENSION pgcrypto;" 2>/dev/null
    LINE="localhost:5432:*:farmayii:farmayii"
    FILE=~/.pgpass
    if [ ! -f $FILE ]; then
        touch $FILE
        chmod 600 $FILE
    fi
    if ! grep -qsF "$LINE" $FILE; then
        echo "$LINE" >> $FILE
    fi
fi
