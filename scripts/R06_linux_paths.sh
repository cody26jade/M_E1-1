#!/bin/bash

set -e
exec 2>&1

export LC_ALL=C

echo "========================================"
echo "M_E1-1 R06 - Linux Path Verification"
echo "========================================"

echo
echo "[01] Create test file"
set -x
mkdir -p /tmp/codyssey-r06/app
echo "Linux Path Test" > /tmp/codyssey-r06/app/test.txt
cd /tmp/codyssey-r06
pwd
set +x

echo
echo "[02] Absolute path"
set -x
ls -l /tmp/codyssey-r06/app/test.txt
cat /tmp/codyssey-r06/app/test.txt
set +x

echo
echo "[03] Relative path"
set -x
ls -l ./app/test.txt
cat ./app/test.txt
set +x

echo
echo "[04] Compare resolved paths"
set -x
realpath /tmp/codyssey-r06/app/test.txt
realpath ./app/test.txt
set +x

echo
echo "[05] Compare file identity"
set -x
test /tmp/codyssey-r06/app/test.txt -ef ./app/test.txt
set +x
echo "PASS: Both Linux paths identify the same file"

echo
echo "[06] Compare file hashes"
set -x
sha256sum /tmp/codyssey-r06/app/test.txt
sha256sum ./app/test.txt
set +x

echo
echo "[07] Parent directory relative path"
set -x
cd app
pwd
cat ../app/test.txt
test ../app/test.txt -ef ./test.txt
set +x
echo "PASS: Parent directory path verified"

echo
echo "[08] Cleanup"
set -x
cd /tmp
rm /tmp/codyssey-r06/app/test.txt
rmdir /tmp/codyssey-r06/app
rmdir /tmp/codyssey-r06
test ! -e /tmp/codyssey-r06
set +x

echo
echo "========================================"
echo "PASS: ALL LINUX PATH TESTS COMPLETED"
echo "========================================"
