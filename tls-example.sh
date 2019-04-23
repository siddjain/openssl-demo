#!/bin/bash
# - The purpose of this script is to illustrate how to create a TLS certificate
# - The script assumes Root CA (RCA) and Intermediate CA have been created

# Step 1: create a certificate signing request i.e., tell us what certificate you want
#         the subj command line option is just there to show how to use it to avoid typing on command line
openssl req -new -nodes -newkey ec:<(openssl ecparam -name prime256v1) \
-out tls-csr.pem -keyout tls.key \
-subj "/C=US/ST=New York/L=Brooklyn/O=Example Corp/OU=client/OU=FBI/CN=example.com" \
-config tls.cnf

# Step 2: Print out the CSR for informational purposes
openssl req -text -in tls-csr.pem

# Step 3: This is the crucial step. In this step the CA will sign (thus bless and legitimize)
#         the certificate from Step 1. To for this succeed, we require setup.sh to be run
./setup.sh
openssl ca -config ica-sign.cnf -extensions v3_ca -create_serial -out tls.pem -notext -infiles tls-csr.pem   
 
# Step 4: Print out the certificate for informational purposes
openssl x509 -in tls.pem -text -noout
