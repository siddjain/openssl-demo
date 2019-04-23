#!/bin/bash
# - Run this script after you have obtained RCA, ICA and TLS certificates i.e., `rca.pem`, `ica.pem` and `tls.pem` files respectively
# - This script verifies integrity of the TLS certificate
set -e
if [ -f ca-chain.pem ]; then
   rm ca-chain.pem
fi
cat ica.pem rca.pem > ca-chain.pem
set -x
openssl verify -CAfile ca-chain.pem tls.pem
