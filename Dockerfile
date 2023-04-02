# Builder image
FROM ubuntu:focal AS builder

RUN apt-get -y update
RUN apt-get -y install  \
        build-essential \
        gcc-multilib \
        g++-multilib
# RUN rm -rf /var/lib/apt/lists/*

WORKDIR /service

COPY src/ ./

RUN make build

# Runner image
FROM ubuntu:focal as runner

RUN apt-get -y update && \
    apt-get -y install socat libc6-i386 && \
    rm -rf /var/lib/apt/lists/*

COPY ./entrypoint.sh /
RUN chmod ug+x /entrypoint.sh

WORKDIR /service

RUN echo "HACK{FAKE_FLAG}" > flag_$(cat /dev/urandom | tr -dc '[:alpha:]' | fold -w ${1:-20} | head -n 1)

COPY --from=builder /service/tropklean tropklean

EXPOSE 1337

ENTRYPOINT [ "/bin/sh", "-c", "/entrypoint.sh" ]