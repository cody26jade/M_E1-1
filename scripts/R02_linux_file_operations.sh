#!/bin/bash

set -e

export LC_ALL=C

echo "========================================"
echo "M_E1-1 R02 - Linux File Operations"
echo "========================================"

echo
echo "[01] Current directory"
set -x
pwd
set +x

echo
echo "[02] Create directories"
set -x
mkdir -p /tmp/codyssey-r02/source
mkdir -p /tmp/codyssey-r02/target
cd /tmp/codyssey-r02
ls -ld source target
set +x

echo
echo "[03] Create a file"
set -x
touch source/mission.txt
ls -l source/mission.txt
set +x

echo
echo "[04] Write and read file contents"
set -x
echo "Codyssey Linux File Operation Test" > source/mission.txt
cat source/mission.txt
set +x

echo
echo "[05] Copy a file"
set -x
cp source/mission.txt target/copy.txt
ls -l source/mission.txt target/copy.txt
cmp source/mission.txt target/copy.txt
set +x
echo "PASS: Copied file contents are identical"

echo
echo "[06] Move and rename a file"
set -x
mv source/mission.txt target/moved.txt
ls -la source
ls -l target/moved.txt
test ! -e source/mission.txt
test -f target/moved.txt
set +x
echo "PASS: File moved successfully"

echo
echo "[07] Delete files"
set -x
rm target/copy.txt
rm target/moved.txt
ls -la target
test ! -e target/copy.txt
test ! -e target/moved.txt
set +x
echo "PASS: Files deleted successfully"

echo
echo "[08] Delete empty directories"
set -x
rmdir source target
ls -la
test ! -d source
test ! -d target
set +x
echo "PASS: Directories deleted successfully"

echo
echo "[09] Final cleanup"
set -x
cd /tmp
rmdir /tmp/codyssey-r02
test ! -e /tmp/codyssey-r02
set +x

echo
echo "========================================"
echo "PASS: ALL LINUX FILE OPERATIONS COMPLETED"
echo "========================================"
