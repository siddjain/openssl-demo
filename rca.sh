#!/bin/bash
# - This script will generate a self-signed Root CA certificate
# - WARNING: openssl is very finicky about the order of command line options
# - see https://security.stackexchange.com/a/78624/44139 for discussion on which curve to choose
# - also see https://github.com/openssl/openssl/issues/309
# - A X25519 key can be generated by running
#   openssl genpkey -algorithm X25519 -out xkey.pem
# - The resulting certificate can be viewed by running
#   openssl x509 -in rca.pem -text -noout
openssl req -new -x509 -nodes -newkey ec:<(openssl ecparam -name prime256v1) -keyout rca.key -out rca.pem -days 365 -config rca.cnf
openssl x509 -in rca.pem -text -noout