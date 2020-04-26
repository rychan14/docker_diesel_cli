FROM rust:latest AS builder
RUN cargo install diesel_cli --no-default-features --features postgres

FROM debian:stretch-slim

RUN apt-get update && \
    apt-get install -y \ 
    libpq-dev && \
    rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/cargo/bin/diesel /bin/diesel

WORKDIR /usr/src

CMD [ "diesel" ]