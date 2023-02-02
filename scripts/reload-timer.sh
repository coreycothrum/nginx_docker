#!/usr/bin/env sh
while :
do
    sleep 6h &
    wait $!;
    nginx -s reload;
done & # detached process
