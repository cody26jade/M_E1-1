#!/bin/bash

set -e

# Merge STDERR into STDOUT for ordered evidence.
exec 2>&1

export LC_ALL=C

echo "========================================"
echo "M_E1-1 R03 - Linux File Permissions"
echo "========================================"

echo
echo "[01] Create test directory and file"
set -x
mkdir -p /tmp/codyssey-r03
cd /tmp/codyssey-r03
printf '#!/bin/bash\n echo "PASS: Script executed successfully"\n' > permission_test.sh
ls -l permission_test.sh
set +x

echo
echo "[02] Permission 644"
echo "Owner: rw- / Group: r-- / Others: r--"
set -x
chmod 644 permission_test.sh
ls -l permission_test.sh
stat -c '%a %A %n' permission_test.sh
test "$(stat -c '%a' permission_test.sh)" = "644"
set +x
echo "PASS: chmod 644 verified"

echo
echo "[03] Permission 755"
echo "Owner: rwx / Group: r-x / Others: r-x"
set -x
ls -l permission_test.sh
chmod 755 permission_test.sh
ls -l permission_test.sh
stat -c '%a %A %n' permission_test.sh
test "$(stat -c '%a' permission_test.sh)" = "755"
./permission_test.sh
set +x
echo "PASS: chmod 755 verified"

echo
echo "[04] Permission 600"
echo "Owner: rw- / Group: --- / Others: ---"
set -x
ls -l permission_test.sh
chmod 600 permission_test.sh
ls -l permission_test.sh
stat -c '%a %A %n' permission_test.sh
test "$(stat -c '%a' permission_test.sh)" = "600"
set +x
echo "PASS: chmod 600 verified"

echo
echo "[05] Symbolic permission u+x"
echo "Add execute permission for owner"
set -x
ls -l permission_test.sh
chmod u+x permission_test.sh
ls -l permission_test.sh
stat -c '%a %A %n' permission_test.sh
test "$(stat -c '%a' permission_test.sh)" = "700"
./permission_test.sh
set +x
echo "PASS: chmod u+x verified"

echo
echo "[06] Symbolic permission g+rx,o+rx"
echo "Add read and execute permission for group and others"
set -x
ls -l permission_test.sh
chmod g+rx,o+rx permission_test.sh
ls -l permission_test.sh
stat -c '%a %A %n' permission_test.sh
test "$(stat -c '%a' permission_test.sh)" = "755"
set +x
echo "PASS: Symbolic permission verified"

echo
echo "[07] Remove execute permission"
set -x
ls -l permission_test.sh
chmod a-x permission_test.sh
ls -l permission_test.sh
stat -c '%a %A %n' permission_test.sh
test "$(stat -c '%a' permission_test.sh)" = "644"
set +x
echo "PASS: Execute permission removed"

echo
echo "[08] Final cleanup"
set -x
rm permission_test.sh
cd /tmp
rmdir /tmp/codyssey-r03
test ! -e /tmp/codyssey-r03
set +x

echo
echo "========================================"
echo "PASS: ALL LINUX PERMISSION TESTS COMPLETED"
echo "========================================"
