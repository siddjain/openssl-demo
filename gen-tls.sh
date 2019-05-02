#!/bin/bash

# - The purpose of this script is to illustrate how to create a TLS certificate
# - The script assumes Root CA (RCA) and Intermediate CA have been created
# - Example Usage:

#   $ SAN=DNS:uber-rca-client PEM=uber-rca-client.pem KEY=uber-rca-client.key CA=rca ./gen-tls.sh

# Step 1: create a certificate signing request i.e., tell us what certificate you want
#         the subj command line option is just there to show how to use it to avoid typing on command line
CNF=${CNF:-tls.cnf}
CSR=${CSR:-tls.csr}
PEM=${PEM:-tls.pem}
KEY=${KEY:-tls.key}
CA=${CA:-ica}

openssl req -new -nodes -newkey ec:<(openssl ecparam -name prime256v1) \
-out $CSR -keyout $KEY \
-config $CNF

# Step 2: Print out the CSR for informational purposes
openssl req -text -in $CSR

# Step 3: This is the crucial step. In this step the CA will sign (thus bless and legitimize)
#         the certificate from Step 1. To for this succeed, we require setup.sh to be run
./setup.sh
openssl ca -config $CA-sign.cnf -extensions v3_ca -create_serial -out $PEM -notext -infiles $CSR  
 
# Step 4: Print out the certificate for informational purposes
openssl x509 -in $PEM -text -noout
