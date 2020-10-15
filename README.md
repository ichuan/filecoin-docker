# filecoin-docker
Dockerfile for filecoin


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

<https://docs.filecoin.io/get-started/lotus/installation/#chain-sync>

```bash
docker run --rm -it -v /data/blockchain/filecoin:/root/.lotus --entrypoint sh mixhq/filecoin
# then in container
/opt/coin/lotus daemon --import-snapshot https://very-temporary-spacerace-chain-snapshot.s3.amazonaws.com/Spacerace_pruned_stateroots_snapshot_latest.car
```


# Using pre-built docker image

Using automated build image from <https://hub.docker.com/r/mixhq/filecoin/>:

```bash
docker run --rm -itd --name fil -p 1234:1234 -p 3030:3030 -v `pwd`/data:/root/.lotus mixhq/filecoin
```
