#!/bin/sh

test_description="encrypt / decrypt"

. ./sharness.sh

setup() {
  tmp_encrypted=$(mktemp)
  tmp_decrypted=$(mktemp)
  eyaml createkeys
  trap "rm -rf $tmp_encrypted $tmp_decrypted keys" EXIT
}


test_expect_success "test setup" "
  setup
"

test_expect_success "source yaml present" "
  [ -f ../data/one.yaml ]
"

test_expect_success "eyaml encrypt" "
  eyaml encrypt -e ../data/one.yaml | tee $tmp_encrypted
"

test_expect_success "eyaml contains expected cleartext" "
  grep foo $tmp_encrypted
"

test_expect_success "eyaml does not contain unexpected cleartext" "
  test_expect_code 1 grep bar $tmp_encrypted
"

test_expect_success "eyaml decrypt" "
  eyaml decrypt -e $tmp_encrypted > $tmp_decrypted
"

test_expect_success "decrypted data is the same as original" "
  diff ../data/one.yaml $tmp_decrypted
"

test_done
