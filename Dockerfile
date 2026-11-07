FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04

RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://github.com/OneZeroMiner/onezerominer/releases/download/v1.8.5/onezerominer-linux-1.8.5.tar.gz | tar xz -C /opt
WORKDIR /opt/onezerominer-linux

CMD exec ./onezerominer -a pearl -w prl1p062nyyn7u8y7l44n8z0a8229cxfy03yfzfhj2pu37raje34u9kesghws6g -o us.pearl.herominers.com:1200 --worker salad-$(hostname)
