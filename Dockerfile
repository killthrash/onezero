FROM nvidia/cuda:12.8.1-runtime-ubuntu22.04

RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://github.com/OneZeroMiner/onezerominer/releases/download/v1.8.5/onezerominer-linux-1.8.5.tar.gz | tar xz -C /opt

COPY run.sh /opt/run.sh
CMD ["sh", "/opt/run.sh"]
