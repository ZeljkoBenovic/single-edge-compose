#!/bin/sh

if [ -f "/data/genesis.json" ]; then
  exit 0
fi

apk add jq

EDGE="/usr/local/bin/polygon-edge"
GENESIS="genesis"
NODE_ID="$($EDGE secrets output --data-dir /data --json | jq -r '.node_id')"
NODE_ADDRESS="$($EDGE secrets output --data-dir /data --json | jq -r '.address')"
PREMINE="--premine $PREMINE_ACC:0xD3C21BCECCEDA1000000"

DEFAULTS="--block-gas-limit 30000000 --epoch-size 100000 --chain-id 51001 --name polygon-edge"
PARAMS="--dir /data/genesis.json --ibft-validator-type ecdsa --ibft-validator $NODE_ADDRESS"
BOOTNODE="--bootnode /dns4/polygon-edge/tcp/1478/p2p/$NODE_ID"

$EDGE $GENESIS $DEFAULTS $PARAMS $PREMINE $BOOTNODE

