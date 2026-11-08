#!/bin/sh
# Pick the pool region with the fastest TCP connect from wherever this node is.
best=$(for r in us us2 us3 ca br fr de es fi ru tr hk jp sg au; do
  t=$(curl -so /dev/null -m 3 -w '%{time_connect}' telnet://$r.pearl.herominers.com:1200)
  echo "$t $r"
done | awk '$1>0' | sort -n | head -1 | cut -d' ' -f2)
echo "pool region: ${best:-us}"
cd /opt/onezerominer-linux
exec ./onezerominer -a pearl -w prl1prxkhr2d57pv9rytsv2qnyqjdat0aa0xarcgm66fa85yd7nj8m8gqkl3yew -o ${best:-us}.pearl.herominers.com:1200 --worker salad-$(hostname)
