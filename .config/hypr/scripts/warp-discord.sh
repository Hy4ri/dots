#!/usr/bin/env bash

warp-cli mode proxy
warp-cli connect
ALL_PROXY="socks5://127.0.0.1:40000" equibop
