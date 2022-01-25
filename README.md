Rust Docker Example
===================

This is an example project that builds and runs rust inside of a docker container.
Uses a multi-stage dockerfile to speed up build. This dockerfile will only
rebuild the first stage if the Cargo.toml files change.

Build the container.

```
sudo docker build -t rust-docker-service-example .
```

Run the container.

```
sudo docker run --rm -p 3000:3000 -ti rust-docker-service-example
```

# Usage

This service simply returns `Hello, World` when requesting the root path.

```
curl http://localhost:3000/
```

returns "Hello, World"
