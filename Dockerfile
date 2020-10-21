FROM rust:latest AS builder
WORKDIR /opt
# build filecoin-service
RUN git clone https://github.com/Zondax/filecoin-signing-tools
RUN cd filecoin-signing-tools && cargo build --release --manifest-path service/Cargo.toml
# build lotus
RUN apt update && apt install -y jq ocl-icd-opencl-dev
RUN wget -c https://dl.google.com/go/go1.14.7.linux-amd64.tar.gz -O - | tar -xz -C /usr/local
RUN git clone https://github.com/filecoin-project/lotus.git
WORKDIR /opt/lotus
RUN git checkout v1.1.0
RUN PATH="$PATH:/usr/local/go/bin" make clean all

FROM ubuntu:18.04
WORKDIR /opt/coin
RUN apt update && apt install -y wget ocl-icd-opencl-dev libssl-dev netcat
COPY --from=builder /opt/filecoin-signing-tools/target/release/filecoin-service /opt/coin/
COPY --from=builder /opt/lotus/lotus /opt/coin/
COPY ./entrypoint.sh /opt/
RUN chmod +x /opt/entrypoint.sh
# cleanup
RUN apt autoremove -y && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/opt/entrypoint.sh"]
