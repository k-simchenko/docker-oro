1. Need your ssh keys (private and pub) and add you pub key to authorized_keys in folder /php8.2/ssh/
2. Need create certs for nginx folder /certs/ - this example for mac https://web.dev/articles/how-to-use-local-https?hl=en, and need setting in /nginx/conf.d.oro/oro.conf. And add domain to hosts.
3. ./init-oro.sh - for start this docker with ssh server
4. After connect to server (ssh) - you can use scripts for enable and disable xdebug. /disable_xdebug.sh OR /enable_xdebug.sh 
