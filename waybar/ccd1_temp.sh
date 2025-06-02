sensors | awk '/k10temp-pci-00c3/{f=1} f && /Tccd1/{sub(/.$/, "", $2); gsub(/°/, "", $2); print $2; f=0}'
