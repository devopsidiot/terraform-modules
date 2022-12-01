client
dev tun
proto udp
remote random.${ endpoint } 443
remote-random-hostname
resolv-retry infinite
nobind
remote-cert-tls server
cipher AES-256-GCM
verb 3
<ca>
${ ca }
</ca>

reneg-sec 0

<cert>
${ cert }
</cert>
<key>
${ key }
</key>