FROM ekidd/rust-musl-builder as builder
LABEL maintainer="kraus1049 <kraus1049@gmail.com>"

RUN git clone https://github.com/sharkdp/fd && \
    cd ./fd && \
    cargo build --release && \
    mkdir /home/rust/work && \
    strip ./target/x86_64-unknown-linux-musl/release/fd


FROM scratch as runner
#FROM alpine as runner
COPY --from=builder /home/rust/src/fd/target/x86_64-unknown-linux-musl/release/fd /fd
COPY --from=builder /home/rust/work /work
ENV PATH=/:PATH
WORKDIR /work

CMD ["/fd"]
