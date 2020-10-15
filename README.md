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
```

# Using pre-built docker image

Using automated build image from <https://hub.docker.com/r/mixhq/filecoin/>:

```bash
docker run --rm -itd --name fil -p 1234:1234 -p 3030:3030 -v `pwd`/data:/root/.lotus mixhq/filecoin
```
