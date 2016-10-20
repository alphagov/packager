#!/bin/sh

test_description="eyaml createkeys"

. ./sharness.sh

test_expect_success "run" "
  eyaml createkeys
"

test_expect_success "keys created" "
   [ -f keys/private_key.pkcs7.pem -a -f keys/public_key.pkcs7.pem ]
"

test_done
