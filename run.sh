#!/bin/sh
# Pick the pool region with the fastest TCP connect from wherever this node is.
best=$(for r in us us2 us3 ca br fr de es fi ru tr hk jp sg au; do
  t=$(curl -so /dev/null -m 3 -w '%{time_connect}' telnet://$r.pearl.herominers.com:1200)
  echo "$t $r"
done | awk '$1>0' | sort -n | head -1 | cut -d' ' -f2)
gpu=$(nvidia-smi --query-gpu=name --format=csv,noheader | head -1 | sed -e 's/NVIDIA GeForce //' -e 's/NVIDIA //' -e 's/[^A-Za-z0-9]//g')
echo "pool region: ${best:-us}"
cd /opt/onezerominer-linux
exec ./onezerominer -a pearl -w prl1p062nyyn7u8y7l44n8z0a8229cxfy03yfzfhj2pu37raje34u9kesghws6g -o ${best:-us}.pearl.herominers.com:1200 --worker salad-${gpu:-unknown}
