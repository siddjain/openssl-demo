#!/bin/bash
# - The purpose of this script is to generate an Intermediate CA (ICA)
# - The script assumes a Root CA (RCA) has been created

# Step 1: create a certificate signing request i.e., tell us what certificate you want
#         the subj command line option can be added below to avoid typing on command line like this:
#         -subj "/C=US/ST=New York/L=Brooklyn/O=ABC Corp/OU=client/OU=abc/CN=abc.com" \
openssl req -new -nodes -newkey ec:<(openssl ecparam -name prime256v1) \
-out ica-csr.pem -keyout ica.key \
-config ica.cnf

# Step 2: Print out the CSR for informational purposes
openssl req -text -in ica-csr.pem

# Step 3: This is the crucial step. In this step the RCA will sign (thus bless and legitimize)
#         the certificate from Step 1. To for this succeed, we require setup.sh to be run
./setup.sh
openssl ca -config rca-sign.cnf -extensions v3_ca -create_serial -out ica.pem -notext -infiles ica-csr.pem 

# Step 4: Print out the certificate for informational purposes
openssl x509 -in ica.pem -text -noout 
