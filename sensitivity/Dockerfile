FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y git bash fish screen rsync htop file curl

# set fish as default shell

RUN echo /usr/bin/fish | tee -a /etc/shells
RUN chsh -s /usr/bin/fish

WORKDIR /root/localTools

# Install ninja-build
RUN  apt-get install -y ninja-build xz-utils pkg-config

# Clone Depot tools repository
RUN mkdir -p /root/localTools && \
    git clone --depth=1 https://chromium.googlesource.com/chromium/tools/depot_tools.git /root/localTools/depot_tools

# Modify PATH environment variable
RUN fish -c "fish_add_path /root/localTools/depot_tools"
ENV PATH="/root/localTools/depot_tools:$PATH"


# Install Swift
RUN apt-get install -y binutils git gnupg2 libc6-dev libcurl4-openssl-dev libedit2 libgcc-9-dev libpython3.11 libsqlite3-0 libstdc++-9-dev libxml2-dev libz3-dev pkg-config tzdata unzip zlib1g-dev gpg
RUN mkdir -p /root/swift_tmp && \
    curl -L https://swift.org/keys/all-keys.asc -o /root/swift_tmp/all-keys.asc
RUN gpg --import /root/swift_tmp/all-keys.asc
RUN gpg --keyserver hkp://keyserver.ubuntu.com --refresh-keys Swift
RUN mkdir -p /root/swift_tmp && \
    curl -L https://download.swift.org/swift-5.9.2-release/ubuntu2204/swift-5.9.2-RELEASE/swift-5.9.2-RELEASE-ubuntu22.04.tar.gz -o /root/swift_tmp/swift.tar.gz
RUN curl -L https://download.swift.org/swift-5.9.2-release/ubuntu2204/swift-5.9.2-RELEASE/swift-5.9.2-RELEASE-ubuntu22.04.tar.gz.sig -o /root/swift_tmp/swift.tar.gz.sig
RUN gpg --verify /root/swift_tmp/swift.tar.gz.sig
RUN mkdir -p /root/localTools/swift
RUN tar -xzf /root/swift_tmp/swift.tar.gz -C /root/localTools/swift --strip-components=1
RUN fish -c "fish_add_path /root/localTools/swift/usr/bin"
ENV PATH="/root/localTools/swift/usr/bin:$PATH"
RUN rm -rf /root/swift_tmp

# Install fuzzilli
RUN git clone https://github.com/googleprojectzero/fuzzilli.git /root/localTools/fuzzilli

WORKDIR /root/localTools/fuzzilli
COPY dumpling_fuzzilli_sensitivity.patch dumpling_fuzzilli_sensitivity.patch
RUN git checkout 5696921ce2b021f5dacd56ba29f2a022c85b5891
RUN git apply dumpling_fuzzilli_sensitivity.patch
RUN swift build -c release

WORKDIR /root/localTools
# Fetch v8
RUN /root/localTools/depot_tools/fetch v8
WORKDIR /root/localTools/v8
COPY dumpling_v8.patch dumpling_v8.patch
RUN git checkout 6e70dc9e73af2a930074f4f000864fbc65515b74
RUN git apply dumpling_v8.patch
RUN ~/localTools/depot_tools/gclient sync -D
RUN ~/localTools/fuzzilli/Targets/V8/fuzzbuild.sh

WORKDIR /root/localTools/fuzzilli
COPY entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

# eval_sensitivity.py
RUN apt-get install -y python3-pip
COPY eval_sensitivity.py eval_sensitivity.py
RUN pip install seaborn matplotlib pandas

ENTRYPOINT ./entrypoint.sh
