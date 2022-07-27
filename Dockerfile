FROM ghcr.io/ichuan/filecoin-signing-tools AS fs_builder
FROM rust:latest AS lotus_builder
WORKDIR /opt
RUN apt update && apt install -y jq ocl-icd-opencl-dev hwloc libhwloc-dev
RUN wget -c https://dl.google.com/go/go1.18.4.linux-amd64.tar.gz -O - | tar -xz -C /usr/local
RUN git clone https://github.com/filecoin-project/lotus.git
WORKDIR /opt/lotus
RUN git checkout v1.16.1
RUN PATH="$PATH:/usr/local/go/bin" make clean all

FROM ubuntu:18.04
WORKDIR /opt/coin
RUN apt update && apt install -y wget ocl-icd-opencl-dev libssl-dev netcat hwloc libhwloc-dev
COPY --from=fs_builder /opt/filecoin-service/target/release/filecoin-service /opt/coin/
COPY --from=lotus_builder /opt/lotus/lotus /opt/coin/
COPY ./entrypoint.sh /opt/
RUN chmod +x /opt/entrypoint.sh
# cleanup
RUN apt autoremove -y && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/opt/entrypoint.sh"]
