FROM rust:1.58.1-alpine as base
WORKDIR /app

# first stage: pull dependencies
FROM base AS cargobuilder

# install build dependencies
RUN apk add gcc musl-dev python3-dev libffi-dev openssl-dev

# install cargo depedencies
COPY Cargo.toml .
COPY Cargo.lock .
RUN mkdir src && touch src/main.rs
RUN cargo fetch

# second stage: source code
FROM base AS release
ENV TZ UTC

COPY . .
COPY --from=cargobuilder --chown=1000:1000 /usr/local/cargo/registry /usr/local/cargo/registry
COPY --from=cargobuilder --chown=1000:1000 /app/Cargo.toml ./Cargo.toml
COPY --from=cargobuilder --chown=1000:1000 /app/Cargo.lock ./Cargo.lock

# musl-dev is required by some deps
RUN apk add musl-dev
RUN cargo build --release

USER 1000:1000
CMD [ "./target/release/rust-docker-example" ]
