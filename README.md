This document describes:  
- How to use openssl to create a Certificate Authority (CA)  
- How to use the CA above to issue TLS Certificate  

# Generating Root CA Certificate
Run `rca.sh` to generate a root CA cert. It should output two files: `rca.pem` (public cert) and `rca.key` (private key)

# Generating Intermediate CA Certificate
Run `ica.sh`. See example log in file `ica-log.txt`

# Generating TLS Certificate
Run `tls-example.sh`. See example log in file `tls-example-log.txt`

# Verifying TLS Certificate
```
$ ./verify.sh
+ openssl verify -CAfile ca-chain.pem tls.pem
tls.pem: OK
```

# Notes
- The examples use ECDSA and [P-256](https://security.stackexchange.com/questions/78621/which-elliptic-curve-should-i-use) curve. Read [this](https://github.com/nodejs/node/issues/1495) and decide for yourself if its safe for your case.  
- The [rand_serial](https://www.openssl.org/docs/manmaster/man1/ca.html) command line option to generate random serial number did not work for me.  
- Openssl is very finicky and it looks like it is sensitive to the order of command line options.  
- You can see the version of OpenSSL by running `openssl version`.  
 
# Troubleshooting
Error:
```
Sign the certificate? [y/n]:y
failed to update database
TXT_DB error number 2
```

Cause:
You are trying to generate a certificate for a CN for which a certificate has been issued previously

Solution:
Open the `index.txt` file and delete the line for the CN for which you are trying to generate new certificate