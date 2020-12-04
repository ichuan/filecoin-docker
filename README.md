# filecoin-docker
Dockerfile for filecoin (with filecoin-signing-tools inside).


# Building

```bash
docker build -t filecoin .
```

# Running

```bash
# block dir
mkdir data
docker run --rm -itd --name fil -p 1234:1234 -p 3030:3030 -v `pwd`/data:/root/.lotus filecoin

# create readonly token
docker exec -it fil /opt/coin/lotus auth create-token --perm read
```


# Speedup ipfs in China

```bash
# https://docs.filecoin.io/get-started/lotus/tips-running-in-china/#speed-up-proof-parameter-download-for-first-boot
docker run -e IPFS_GATEWAY=https://proof-parameters.s3.cn-south-1.jdcloud-oss.com/ipfs/ --rm -itd --name fil -p 1234:1234 -p 3030:3030 -v `pwd`/data:/root/.lotus filecoin
```


# Importing snapshot

On the first run, you need to sync to the mainchain:

<https://docs.filecoin.io/get-started/lotus/chain/#syncing>

```bash
docker run --rm -it -v /data/blockchain/filecoin:/root/.lotus --entrypoint /opt/coin/lotus mixhq/filecoin daemon --halt-after-import --import-snapshot https://fil-chain-snapshots-fallback.s3.amazonaws.com/mainnet/minimal_finality_stateroots_latest.car
```


# Only running filecoin-service

Don't run the lotus node

```bash
docker run -e WITHOUT_NODE=1 -e LOTUS_ADDR=1.1.1.1:1234 -e LOTUS_TOKEN=THE_JWT_TOKEN --rm -itd --name fil -p 1234:1234 -p 3030:3030 -v `pwd`/data:/root/.lotus filecoin
```


# Using pre-built docker image

Using automated build image from <https://hub.docker.com/r/mixhq/filecoin/>:

```bash
docker run --rm -itd --name fil -p 1234:1234 -p 3030:3030 -v `pwd`/data:/root/.lotus mixhq/filecoin
```
