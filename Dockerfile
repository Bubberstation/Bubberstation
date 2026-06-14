FROM archlinux:base-devel

ENV RUSTUP_INIT_SKIP_PATH_CHECK=yes
RUN echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
RUN pacman -Syu --noconfirm \
    curl \
    wget \
    unzip \
    sudo \
    python3 \
    python-pip \
    git \
    rustup \
    nodejs \
    npm \
    multilib-devel \
    lib32-gcc-libs \
    lib32-zlib \
    lib32-glibc \
    lib32-curl \
    && pacman -Scc --noconfirm \
    && ldconfig

RUN rustup default stable && \
    rustup target add i686-unknown-linux-gnu

RUN git clone https://github.com/tgstation/rust-g && \
    cd ./rust-g && \
    PKG_CONFIG_ALLOW_CROSS=1 && \
    PKG_CONFIG_PATH=/usr/lib32/pkgconfig && \
    RUSTFLAGS="-C target-cpu=native" && \
    CARGO_TARGET_I686_UNKNOWN_LINUX_GNU_LINKER=gcc && \
    rustup run stable cargo build --release --features all --target i686-unknown-linux-gnu

RUN pip3 install --break-system-packages yt-dlp

RUN wget https://www.byond.com/download/build/516/516.1682_byond_linux.zip && \
    unzip 516.1682_byond_linux.zip && \
    cd /byond && make here && make install

ENV PATH="${PATH}:/byond/bin"

RUN echo "/usr/lib32" >> /etc/ld.so.conf.d/lib32-glibc.conf && ldconfig
RUN cp /rust-g/target/i686-unknown-linux-gnu/release/librust_g.so /byond/bin/librust_g.so
RUN cp /rust-g/target/i686-unknown-linux-gnu/release/librust_g.so /usr/local/byond/bin/librust_g.so
#thanks I hate it too
ENV LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/local/byond/bin"
RUN chmod -R 777 /byond/bin
RUN ldconfig
WORKDIR /app
ARG BUILDARGS=""
#COPY . .
EXPOSE 3000
