#!/bin/sh
# Rank pool regions by TCP connect time; pass the 3 fastest as failover pools (miner tries them in order).
pools=$(for r in us us2 us3 ca br fr de es fi ru tr hk jp sg au; do
  t=$(curl -so /dev/null -m 3 -w '%{time_connect}' telnet://$r.pearl.herominers.com:1200)
  echo "$t $r"
done | awk '$1>0' | sort -n | head -3 | awk '{printf "%s.pearl.herominers.com:1200 ", $2}')
pools=${pools:-us.pearl.herominers.com:1200 de.pearl.herominers.com:1200}
# GPU name: env var GPU_NAME wins, else nvidia-smi, else the kernel driver's /proc entry.
gpu=${GPU_NAME:-$( (nvidia-smi --query-gpu=name --format=csv,noheader || sed -n 's/^Model: *//p' /proc/driver/nvidia/gpus/*/information) 2>/dev/null | head -1 | sed -e 's/NVIDIA GeForce //' -e 's/NVIDIA //' -e 's/[^A-Za-z0-9]//g')}
echo "pools: $pools gpu: ${gpu:-unknown}"
cd /opt/onezerominer-linux
# shellcheck disable=SC2086
exec ./onezerominer -a pearl -w prl1p062nyyn7u8y7l44n8z0a8229cxfy03yfzfhj2pu37raje34u9kesghws6g -o $pools --worker salad-${gpu:-unknown}
