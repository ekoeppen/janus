FROM alpine:3.16 as dev
RUN apk add --no-cache gcc libc-dev make diffutils m4 emacs rust cargo readline-dev linux-headers musl-dev

WORKDIR /build

RUN wget http://ftp.funet.fi/pub/gnu/prep/gforth/gforth-0.7.3.tar.gz && tar xf gforth-0.7.3.tar.gz
RUN cd gforth-0.7.3 && CFLAGS='-std=gnu99' ./configure \
		--prefix=/usr/local \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--without-check
RUN cd gforth-0.7.3 && make && make install

RUN wget -O - https://github.com/ekoeppen/p3216/archive/v1.6.1.tar.gz | tar xfz -
RUN cd p3216-1.6.1 && cargo build --release

RUN wget -O - https://github.com/ekoeppen/thumbulator/archive/v1.1.0.tar.gz | tar xfz -
RUN cd thumbulator-1.1.0 && make && cp thumbulator /usr/local/bin

RUN wget -O - https://github.com/ekoeppen/MSP430-Emulator/archive/v1.0.0.tar.gz | tar xfz -
RUN cd MSP430-Emulator-1.0.0 && make && make install

FROM alpine:3.13 as base
RUN apk add --no-cache libgcc git readline
COPY --from=dev /usr/local /usr/local
COPY --from=dev /build/p3216-1.6.1/target/release/p3216 /usr/bin/p3216
