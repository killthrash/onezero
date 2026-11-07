FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04

RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://github.com/OneZeroMiner/onezerominer/releases/download/v1.8.5/onezerominer-linux-1.8.5.tar.gz | tar xz -C /opt
WORKDIR /opt/onezerominer-linux

CMD exec ./onezerominer -a pearl -w prl1prxkhr2d57pv9rytsv2qnyqjdat0aa0xarcgm66fa85yd7nj8m8gqkl3yew -o us.pearl.herominers.com:1200 --worker salad-$(hostname)
