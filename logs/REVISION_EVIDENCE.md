# M_E1-1 - Actual Execution Evidence

Actual revision execution logs collected on 2026-11-14.

Source: individual execution logs in this directory.

Personal Windows user paths may be masked.
R06 includes an incomplete initial test; R06B records the corrected test.
R08 includes an intentional port conflict and its resolution.

---

## R02_linux_file_operations.txt

````text
CODYSSEY MISSION REPORT SYSTEM
M_E1-1 R02 - Linux File Operations
Date: 2026-11-14 20:42:22

01. Linux Script Verification

> Get-Item ".\scripts\R02_linux_file_operations.sh" |
        Select-Object Name, Length

Name                         Length
----                         ------
R02_linux_file_operations.sh   1678
Failed: False

02. Execute Linux File Operations

> $scriptDir = (Resolve-Path ".\scripts").Path

    docker run --rm --mount "type=bind,source=$scriptDir,target=/scripts,readonly" ubuntu:latest bash /scripts/R02_linux_file_operations.sh
docker : + pwd
위치 줄:14 문자:5
+     docker run --rm --mount "type=bind,source=$scriptDir,target=/scri ...
+     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (+ pwd:String) [], RemoteException
    + FullyQualifiedErrorId : NativeCommandError
 
+ set +x
+ mkdir -p /tmp/codyssey-r02/source
========================================
M_E1-1 R02 - Linux File Operations
========================================

[01] Current directory
/

[02] Create directories
+ mkdir -p /tmp/codyssey-r02/target
+ cd /tmp/codyssey-r02
+ ls -ld source target
drwxr-xr-x 2 root root 4096 Nov 14 11:42 source
drwxr-xr-x 2 root root 4096 Nov 14 11:42 target
+ set +x
+ touch source/mission.txt

[03] Create a file
+ ls -l source/mission.txt
-rw-r--r-- 1 root root 0 Nov 14 11:42 source/mission.txt
+ set +x
+ echo 'Codyssey Linux File Operation Test'

[04] Write and read file contents
+ cat source/mission.txt
Codyssey Linux File Operation Test

[05] Copy a file
+ set +x
+ cp source/mission.txt target/copy.txt
+ ls -l source/mission.txt target/copy.txt
-rw-r--r-- 1 root root 35 Nov 14 11:42 source/mission.txt
-rw-r--r-- 1 root root 35 Nov 14 11:42 target/copy.txt
+ cmp source/mission.txt target/copy.txt
+ set +x
+ mv source/mission.txt target/moved.txt
PASS: Copied file contents are identical

[06] Move and rename a file
+ ls -la source
total 8
drwxr-xr-x 2 root root 4096 Nov 14 11:42 .
drwxr-xr-x 4 root root 4096 Nov 14 11:42 ..
+ ls -l target/moved.txt
-rw-r--r-- 1 root root 35 Nov 14 11:42 target/moved.txt
+ test '!' -e source/mission.txt
+ test -f target/moved.txt
+ set +x
+ rm target/copy.txt
PASS: File moved successfully

[07] Delete files
+ rm target/moved.txt
+ ls -la target
total 8
drwxr-xr-x 2 root root 4096 Nov 14 11:42 .
drwxr-xr-x 4 root root 4096 Nov 14 11:42 ..
+ test '!' -e target/copy.txt
+ test '!' -e target/moved.txt
+ set +x
+ rmdir source target
PASS: Files deleted successfully

[08] Delete empty directories
+ ls -la
total 8
drwxr-xr-x 2 root root 4096 Nov 14 11:42 .
drwxrwxrwt 1 root root 4096 Nov 14 11:42 ..
+ test '!' -d source
+ test '!' -d target
PASS: Directories deleted successfully

[09] Final cleanup
+ set +x
+ cd /tmp
+ rmdir /tmp/codyssey-r02

========================================
PASS: ALL LINUX FILE OPERATIONS COMPLETED
========================================
+ test '!' -e /tmp/codyssey-r02
+ set +x
Failed: False

03. Existing Containers Verification

> docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
NAMES                                 STATUS                     PORTS
codyssey-review-fix-20261114-165754   Up 4 hours                 127.0.0.1:53783->80/tcp
codyssey-review-20261114-165542       Created                    
codyssey-volume-2                     Exited (0) 5 hours ago     
codyssey-bind                         Up 5 hours                 127.0.0.1:30003->80/tcp
codyssey-web-2                        Up 5 hours                 127.0.0.1:30002->80/tcp
codyssey-web-1                        Up 5 hours                 127.0.0.1:30001->80/tcp
confident_pasteur                     Exited (137) 6 hours ago   
sharp_williamson                      Exited (0) 7 hours ago
Failed: False
````

---

## R03_linux_permissions.txt

````text
CODYSSEY MISSION REPORT SYSTEM
M_E1-1 R03 - Linux Permissions
Date: 2026-11-14 20:44:11

01. Permission Script Verification

> Get-Item ".\scripts\R03_linux_permissions.sh" |
        Select-Object Name, Length

Name                     Length
----                     ------
R03_linux_permissions.sh   2528
Failed: False

02. Execute Linux Permission Tests

> $scriptDir = (Resolve-Path ".\scripts").Path

    docker run --rm --mount "type=bind,source=$scriptDir,target=/scripts,readonly" ubuntu:latest bash /scripts/R03_linux_permissions.sh
========================================
M_E1-1 R03 - Linux File Permissions
========================================

[01] Create test directory and file
+ mkdir -p /tmp/codyssey-r03
+ cd /tmp/codyssey-r03
+ printf '#!/bin/bash\n echo "PASS: Script executed successfully"\n'
+ ls -l permission_test.sh
-rw-r--r-- 1 root root 55 Nov 14 11:44 permission_test.sh
+ set +x

[02] Permission 644
Owner: rw- / Group: r-- / Others: r--
+ chmod 644 permission_test.sh
+ ls -l permission_test.sh
-rw-r--r-- 1 root root 55 Nov 14 11:44 permission_test.sh
+ stat -c '%a %A %n' permission_test.sh
644 -rw-r--r-- permission_test.sh
++ stat -c %a permission_test.sh
+ test 644 = 644
+ set +x
PASS: chmod 644 verified

[03] Permission 755
Owner: rwx / Group: r-x / Others: r-x
+ ls -l permission_test.sh
-rw-r--r-- 1 root root 55 Nov 14 11:44 permission_test.sh
+ chmod 755 permission_test.sh
+ ls -l permission_test.sh
-rwxr-xr-x 1 root root 55 Nov 14 11:44 permission_test.sh
+ stat -c '%a %A %n' permission_test.sh
755 -rwxr-xr-x permission_test.sh
++ stat -c %a permission_test.sh
+ test 755 = 755
+ ./permission_test.sh
PASS: Script executed successfully
+ set +x
PASS: chmod 755 verified

[04] Permission 600
Owner: rw- / Group: --- / Others: ---
+ ls -l permission_test.sh
-rwxr-xr-x 1 root root 55 Nov 14 11:44 permission_test.sh
+ chmod 600 permission_test.sh
+ ls -l permission_test.sh
-rw------- 1 root root 55 Nov 14 11:44 permission_test.sh
+ stat -c '%a %A %n' permission_test.sh
600 -rw------- permission_test.sh
++ stat -c %a permission_test.sh
+ test 600 = 600
+ set +x
PASS: chmod 600 verified

[05] Symbolic permission u+x
Add execute permission for owner
+ ls -l permission_test.sh
-rw------- 1 root root 55 Nov 14 11:44 permission_test.sh
+ chmod u+x permission_test.sh
+ ls -l permission_test.sh
-rwx------ 1 root root 55 Nov 14 11:44 permission_test.sh
+ stat -c '%a %A %n' permission_test.sh
700 -rwx------ permission_test.sh
++ stat -c %a permission_test.sh
+ test 700 = 700
+ ./permission_test.sh
PASS: Script executed successfully
+ set +x
PASS: chmod u+x verified

[06] Symbolic permission g+rx,o+rx
Add read and execute permission for group and others
+ ls -l permission_test.sh
-rwx------ 1 root root 55 Nov 14 11:44 permission_test.sh
+ chmod g+rx,o+rx permission_test.sh
+ ls -l permission_test.sh
-rwxr-xr-x 1 root root 55 Nov 14 11:44 permission_test.sh
+ stat -c '%a %A %n' permission_test.sh
755 -rwxr-xr-x permission_test.sh
++ stat -c %a permission_test.sh
+ test 755 = 755
+ set +x
PASS: Symbolic permission verified

[07] Remove execute permission
+ ls -l permission_test.sh
-rwxr-xr-x 1 root root 55 Nov 14 11:44 permission_test.sh
+ chmod a-x permission_test.sh
+ ls -l permission_test.sh
-rw-r--r-- 1 root root 55 Nov 14 11:44 permission_test.sh
+ stat -c '%a %A %n' permission_test.sh
644 -rw-r--r-- permission_test.sh
++ stat -c %a permission_test.sh
+ test 644 = 644
+ set +x
PASS: Execute permission removed

[08] Final cleanup
+ rm permission_test.sh
+ cd /tmp
+ rmdir /tmp/codyssey-r03
+ test '!' -e /tmp/codyssey-r03
+ set +x

========================================
PASS: ALL LINUX PERMISSION TESTS COMPLETED
========================================
Failed: False

03. Existing Containers Verification

> docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
NAMES                                 STATUS                     PORTS
codyssey-review-fix-20261114-165754   Up 4 hours                 127.0.0.1:53783->80/tcp
codyssey-review-20261114-165542       Created                    
codyssey-volume-2                     Exited (0) 5 hours ago     
codyssey-bind                         Up 5 hours                 127.0.0.1:30003->80/tcp
codyssey-web-2                        Up 5 hours                 127.0.0.1:30002->80/tcp
codyssey-web-1                        Up 5 hours                 127.0.0.1:30001->80/tcp
confident_pasteur                     Exited (137) 6 hours ago   
sharp_williamson                      Exited (0) 7 hours ago
Failed: False
````

---

## R04_docker_basic_commands.txt

````text
CODYSSEY MISSION REPORT SYSTEM
M_E1-1 R04 - Docker Basic Commands
Date: 2026-11-14 20:45:29

01. Docker Version

> docker --version
Docker version 29.9.2, build a82e528
Failed: False

02. Docker Client and Server Version

> docker version
Client:
 Version:           29.9.2
 API version:       1.56
 Go version:        go1.26.10
 Git commit:        a82e528
 Built:             Tue Oct 20 19:44:07 2026
 OS/Arch:           windows/amd64
 Context:           desktop-linux

Server: Docker Desktop 4.97.0 (244584)
 Engine:
  Version:          29.9.2
  API version:      1.56 (minimum version 1.40)
  Go version:       go1.26.10
  Git commit:       0367cbe
  Built:            Tue Oct 20 18:45:02 2026
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          v2.4.2
  GitCommit:        b7a25261e029d68978bbf290df0a62fc819b3c51
 runc:
  Version:          1.5.2
  GitCommit:        v1.5.2-0-g29dd3dc2
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
Failed: False

03. Docker Engine Status

> docker info --format "Server Version: {{.ServerVersion}} | OS: {{.OSType}} | Containers: {{.Containers}} | Images: {{.Images}}"
Server Version: 29.9.2 | OS: linux | Containers: 8 | Images: 4
Failed: False

04. Existing Hello World Image

> docker image inspect hello-world:latest --format "Image ID: {{.Id}} | OS: {{.Os}} | Architecture: {{.Architecture}}"
Image ID: sha256:cf1b20a0c89a666b6950fecda7ccbc1b1a86520e7c53f908f3a21e79d0d60458 | OS: linux | Architecture: amd64
Failed: False

05. Execute Hello World Container

> docker run --rm --pull=never hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
Failed: False

06. Docker Images Original Output

> docker images
IMAGE                             ID             DISK USAGE   CONTENT SIZE   EXTRA
codyssey-review:20261114-165542   da0aaa1180ce       93.7MB         26.4MB   U    
codyssey-web:v1                   3af2f6904b6b       93.7MB         26.4MB   U    
hello-world:latest                cf1b20a0c89a       25.9kB         9.49kB   U    
ubuntu:latest                     065aa8626841        163MB         45.9MB   U
Failed: False

07. Docker Images Detailed List

> docker image ls --format "table {{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.Size}}"
REPOSITORY        TAG               IMAGE ID       SIZE
codyssey-review   20261114-165542   da0aaa1180ce   93.7MB
codyssey-web      v1                3af2f6904b6b   93.7MB
hello-world       latest            cf1b20a0c89a   25.9kB
ubuntu            latest            065aa8626841   163MB
Failed: False

08. Docker Running Containers

> docker ps
CONTAINER ID   IMAGE                             COMMAND                   CREATED       STATUS       PORTS                     NAMES
aab569910e59   codyssey-review:20261114-165542   "/docker-entrypoint.??   4 hours ago   Up 4 hours   127.0.0.1:53783->80/tcp   codyssey-review-fix-20261114-165754
d71a1f8cbede   codyssey-web:v1                   "/docker-entrypoint.??   5 hours ago   Up 5 hours   127.0.0.1:30003->80/tcp   codyssey-bind
7f1f296fe05c   codyssey-web:v1                   "/docker-entrypoint.??   6 hours ago   Up 6 hours   127.0.0.1:30002->80/tcp   codyssey-web-2
7e14e6fea41d   codyssey-web:v1                   "/docker-entrypoint.??   6 hours ago   Up 6 hours   127.0.0.1:30001->80/tcp   codyssey-web-1
Failed: False

09. Docker All Containers

> docker ps -a
CONTAINER ID   IMAGE                             COMMAND                   CREATED       STATUS                     PORTS                     NAMES
aab569910e59   codyssey-review:20261114-165542   "/docker-entrypoint.??   4 hours ago   Up 4 hours                 127.0.0.1:53783->80/tcp   codyssey-review-fix-20261114-165754
f47b86edd547   codyssey-review:20261114-165542   "/docker-entrypoint.??   4 hours ago   Created                                              codyssey-review-20261114-165542
0e7589e00a57   ubuntu                            "cat /data/mission.t??   5 hours ago   Exited (0) 5 hours ago                               codyssey-volume-2
d71a1f8cbede   codyssey-web:v1                   "/docker-entrypoint.??   5 hours ago   Up 5 hours                 127.0.0.1:30003->80/tcp   codyssey-bind
7f1f296fe05c   codyssey-web:v1                   "/docker-entrypoint.??   6 hours ago   Up 6 hours                 127.0.0.1:30002->80/tcp   codyssey-web-2
7e14e6fea41d   codyssey-web:v1                   "/docker-entrypoint.??   6 hours ago   Up 6 hours                 127.0.0.1:30001->80/tcp   codyssey-web-1
b703fa220da4   ubuntu                            "bash"                    7 hours ago   Exited (137) 6 hours ago                             confident_pasteur
dbd1ea00eb26   hello-world                       "/hello"                  7 hours ago   Exited (0) 7 hours ago                               sharp_williamson
Failed: False

10. Docker Volume List

> docker volume ls
DRIVER    VOLUME NAME
local     codyssey-data
Failed: False
````

---

## R05_docker_advanced_verification.txt

````text
CODYSSEY MISSION REPORT SYSTEM
M_E1-1 R05 - Docker Advanced Verification
Date: 2026-11-14 20:47:19

01. Dockerfile Original Content

> Get-Content ".\Dockerfile"
FROM nginx:alpine

COPY app/index.html /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
Failed: False

02. Existing Docker Build Evidence

> Get-Content ".\logs\06_docker_build.txt" -Tail 25
#5 extracting sha256:881fc932939efef04ca120ad44bbd2c0917851eb247aa4995428afb1e80ede17 0.1s done
#5 extracting sha256:1abafee971b93c1ae05f03c35c6fb6e3376e75e6f16b590092a822b61ebf10b6 0.1s done
#5 extracting sha256:c7dfd64eeb02740cc41e9f32ad7f75781882d4c167b77427aa9615d1419c4515
#5 extracting sha256:c7dfd64eeb02740cc41e9f32ad7f75781882d4c167b77427aa9615d1419c4515 0.0s done
#5 extracting sha256:e011f124249bf1c4be27b3311c3b40cb90dd7737381af1c62b508020790b7bd5 0.0s done
#5 extracting sha256:a746bd1dc828f61bf43b775dcfecb9ded8a3d3b41789915fe135fa6b9fa85965 0.0s done
#5 extracting sha256:b9c6ee6a30f8811636d7273be348906cf0e4e9725378dd54b7d4a3725538cad4 0.0s done
#5 extracting sha256:69d81d5522572d5b7abcc8f594ecbc4cf9bea72402675a419e8d7b516e4c3f14 0.0s done
#5 extracting sha256:da90db506dd5f2d604467c4dc38442534f74c9e76c1982df0c262e144bad7bc9
#5 extracting sha256:da90db506dd5f2d604467c4dc38442534f74c9e76c1982df0c262e144bad7bc9 0.4s done
#5 DONE 3.4s

#6 [2/2] COPY app/index.html /usr/share/nginx/html/index.html
#6 DONE 0.1s

#7 exporting to image
#7 exporting layers 0.1s done
#7 exporting manifest sha256:e4a43e6d8dee8b275986b552625365576278246d1b42c705a848e33a4ce198fe 0.0s done
#7 exporting config sha256:4fabf1fd8a797bd0e597cf5f079aba16c980858b300640184c2cb8da0f4d5835 0.0s done
#7 exporting attestation manifest sha256:d25b1be9f12088ef153c82776cbd7f9e0bcdd3cb438d092c8094d5b37677bcb1 0.0s done
#7 exporting manifest list sha256:3af2f6904b6bd715dd909e6ec1fa305655bd42bda58ceec465b8d4e570d531be 0.0s done
#7 naming to docker.io/library/codyssey-web:v1 done
#7 unpacking to docker.io/library/codyssey-web:v1
#7 unpacking to docker.io/library/codyssey-web:v1 0.8s done
#7 DONE 0.9s
Failed: False

03. Docker Image Information

> docker image inspect codyssey-web:v1 --format "ID: {{.Id}} | OS: {{.Os}} | Architecture: {{.Architecture}}"
ID: sha256:3af2f6904b6bd715dd909e6ec1fa305655bd42bda58ceec465b8d4e570d531be | OS: linux | Architecture: amd64
Failed: False

04. Docker Network List

> docker network ls
NETWORK ID     NAME      DRIVER    SCOPE
5516e882a252   bridge    bridge    local
344c997f76d3   host      host      local
c2cbeae0a809   none      null      local
Failed: False

05. Container Network Mode

> docker inspect codyssey-web-1 codyssey-web-2 codyssey-bind --format "{{.Name}} | NetworkMode: {{.HostConfig.NetworkMode}}"
/codyssey-web-1 | NetworkMode: bridge
/codyssey-web-2 | NetworkMode: bridge
/codyssey-bind | NetworkMode: bridge
Failed: False

06. Container IP Addresses

> docker inspect codyssey-web-1 codyssey-web-2 codyssey-bind --format "{{.Name}} | {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}"
/codyssey-web-1 | 172.17.0.2
/codyssey-web-2 | 172.17.0.3
/codyssey-bind | 172.17.0.4
Failed: False

07. Container Port Mapping

> docker port codyssey-web-1
    docker port codyssey-web-2
    docker port codyssey-bind
80/tcp -> 127.0.0.1:30001
80/tcp -> 127.0.0.1:30002
80/tcp -> 127.0.0.1:30003
Failed: False

08. Internal Network Namespace

> docker exec codyssey-web-1 readlink /proc/self/ns/net
    docker exec codyssey-web-2 readlink /proc/self/ns/net
    docker exec codyssey-bind readlink /proc/self/ns/net
net:[4026532380]
net:[4026532456]
net:[4026532532]
Failed: False

09. HTTP Response Port 30001

> curl.exe --fail --silent --show-error --max-time 10 -i http://127.0.0.1:30001/
HTTP/1.1 200 OK
Server: nginx/1.31.8
Date: Sat, 14 Nov 2026 11:47:18 GMT
Content-Type: text/html
Content-Length: 2429
Last-Modified: Sat, 14 Nov 2026 05:27:40 GMT
Connection: keep-alive
ETag: "6af7f14c-97d"
Accept-Ranges: bytes

癤?!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Codyssey M_E1-1</title>
    <style>
        body {
            background: #0f172a;
            color: #ffffff;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 50px 25px;
        }
        .container {
            max-width: 850px;
            margin: auto;
        }
        .subtitle {
            color: #38bdf8;
            letter-spacing: 2px;
        }
        h1 {
            font-size: 42px;
            margin-bottom: 10px;
        }
        .description {
            color: #cbd5e1;
        }
        .cards {
            display: flex;
            gap: 20px;
            margin: 30px 0;
        }
        .card {
            flex: 1;
            background: #1e293b;
            padding: 25px;
            border-radius: 12px;
        }
        .status {
            color: #4ade80;
        }
        svg {
            width: 100%;
            background: #1e293b;
            border-radius: 12px;
        }
        footer {
            margin-top: 30px;
            color: #94a3b8;
        }
    </style>
</head>
<body>
    <div class="container">
        <p class="subtitle">2026 CODYSSEY ALL-IN-ONE</p>
        <h1>AI Vibration Analysis</h1>
        <p class="description">Docker Web Server Practice</p>

        <div class="cards">
            <div class="card">
                <p>MISSION</p>
                <h2>M_E1-1</h2>
            </div>
            <div class="card">
                <p>SERVER STATUS</p>
                <h2 class="status">Running</h2>
            </div>
        </div>

        <svg viewBox="0 0 800 150">
            <polyline
                points="0,75 20,45 40,100 60,30 80,110
                100,65 120,95 140,40 160,120 180,50
                200,80 220,35 240,110 260,45 280,90
                300,60 320,115 340,40 360,100 380,55
                400,75 420,45 440,100 460,30 480,110
                500,65 520,95 540,40 560,120 580,50
                600,80 620,35 640,110 660,45 680,90
                700,60 720,115 740,40 760,100 780,55 800,75"
                fill="none"
                stroke="#38bdf8"
                stroke-width="2"
            />
        </svg>

        <footer>
            Linux | Docker | NGINX | GitHub
        </footer>
    </div>
</body>
</html>
Failed: False

10. HTTP Response Port 30002

> curl.exe --fail --silent --show-error --max-time 10 -i http://127.0.0.1:30002/
HTTP/1.1 200 OK
Server: nginx/1.31.8
Date: Sat, 14 Nov 2026 11:47:18 GMT
Content-Type: text/html
Content-Length: 2429
Last-Modified: Sat, 14 Nov 2026 05:27:40 GMT
Connection: keep-alive
ETag: "6af7f14c-97d"
Accept-Ranges: bytes

癤?!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Codyssey M_E1-1</title>
    <style>
        body {
            background: #0f172a;
            color: #ffffff;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 50px 25px;
        }
        .container {
            max-width: 850px;
            margin: auto;
        }
        .subtitle {
            color: #38bdf8;
            letter-spacing: 2px;
        }
        h1 {
            font-size: 42px;
            margin-bottom: 10px;
        }
        .description {
            color: #cbd5e1;
        }
        .cards {
            display: flex;
            gap: 20px;
            margin: 30px 0;
        }
        .card {
            flex: 1;
            background: #1e293b;
            padding: 25px;
            border-radius: 12px;
        }
        .status {
            color: #4ade80;
        }
        svg {
            width: 100%;
            background: #1e293b;
            border-radius: 12px;
        }
        footer {
            margin-top: 30px;
            color: #94a3b8;
        }
    </style>
</head>
<body>
    <div class="container">
        <p class="subtitle">2026 CODYSSEY ALL-IN-ONE</p>
        <h1>AI Vibration Analysis</h1>
        <p class="description">Docker Web Server Practice</p>

        <div class="cards">
            <div class="card">
                <p>MISSION</p>
                <h2>M_E1-1</h2>
            </div>
            <div class="card">
                <p>SERVER STATUS</p>
                <h2 class="status">Running</h2>
            </div>
        </div>

        <svg viewBox="0 0 800 150">
            <polyline
                points="0,75 20,45 40,100 60,30 80,110
                100,65 120,95 140,40 160,120 180,50
                200,80 220,35 240,110 260,45 280,90
                300,60 320,115 340,40 360,100 380,55
                400,75 420,45 440,100 460,30 480,110
                500,65 520,95 540,40 560,120 580,50
                600,80 620,35 640,110 660,45 680,90
                700,60 720,115 740,40 760,100 780,55 800,75"
                fill="none"
                stroke="#38bdf8"
                stroke-width="2"
            />
        </svg>

        <footer>
            Linux | Docker | NGINX | GitHub
        </footer>
    </div>
</body>
</html>
Failed: False

11. HTTP Response Port 30003

> curl.exe --fail --silent --show-error --max-time 10 -i http://127.0.0.1:30003/
HTTP/1.1 200 OK
Server: nginx/1.31.8
Date: Sat, 14 Nov 2026 11:47:18 GMT
Content-Type: text/html
Content-Length: 2430
Last-Modified: Sat, 14 Nov 2026 06:19:44 GMT
Connection: keep-alive
ETag: "6af7fd80-97e"
Accept-Ranges: bytes

癤?!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Codyssey M_E1-1</title>
    <style>
        body {
            background: #0f172a;
            color: #ffffff;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 50px 25px;
        }
        .container {
            max-width: 850px;
            margin: auto;
        }
        .subtitle {
            color: #38bdf8;
            letter-spacing: 2px;
        }
        h1 {
            font-size: 42px;
            margin-bottom: 10px;
        }
        .description {
            color: #cbd5e1;
        }
        .cards {
            display: flex;
            gap: 20px;
            margin: 30px 0;
        }
        .card {
            flex: 1;
            background: #1e293b;
            padding: 25px;
            border-radius: 12px;
        }
        .status {
            color: #4ade80;
        }
        svg {
            width: 100%;
            background: #1e293b;
            border-radius: 12px;
        }
        footer {
            margin-top: 30px;
            color: #94a3b8;
        }
    </style>
</head>
<body>
    <div class="container">
        <p class="subtitle">2026 CODYSSEY ALL-IN-ONE</p>
        <h1>AI Vibration Analysis</h1>
        <p class="description">Bind Mount Update SUCCESS</p>

        <div class="cards">
            <div class="card">
                <p>MISSION</p>
                <h2>M_E1-1</h2>
            </div>
            <div class="card">
                <p>SERVER STATUS</p>
                <h2 class="status">Running</h2>
            </div>
        </div>

        <svg viewBox="0 0 800 150">
            <polyline
                points="0,75 20,45 40,100 60,30 80,110
                100,65 120,95 140,40 160,120 180,50
                200,80 220,35 240,110 260,45 280,90
                300,60 320,115 340,40 360,100 380,55
                400,75 420,45 440,100 460,30 480,110
                500,65 520,95 540,40 560,120 580,50
                600,80 620,35 640,110 660,45 680,90
                700,60 720,115 740,40 760,100 780,55 800,75"
                fill="none"
                stroke="#38bdf8"
                stroke-width="2"
            />
        </svg>

        <footer>
            Linux | Docker | NGINX | GitHub
        </footer>
    </div>
</body>
</html>
Failed: False

12. Bind Mount Information

> docker inspect codyssey-bind --format "{{json .Mounts}}"
[{"Type":"bind","Source":"C:\\2026Codyssey_AllInOne\\M_E1-1\\app","Destination":"/usr/share/nginx/html","Mode":"ro","RW":false,"Propagation":"rprivate"}]
Failed: False

13. Docker Volume Information

> docker volume inspect codyssey-data
[
    {
        "CreatedAt": "2026-11-14T06:22:06Z",
        "Driver": "local",
        "Labels": null,
        "Mountpoint": "/var/lib/docker/volumes/codyssey-data/_data",
        "Name": "codyssey-data",
        "Options": null,
        "Scope": "local"
    }
]
Failed: False

14. Existing Volume Data Verification

> docker run --rm --pull=never --mount "type=volume,source=codyssey-data,target=/data,readonly" ubuntu:latest bash -c 'ls -la /data && cat /data/mission.txt'
total 12
drwxr-xr-x 2 root root 4096 Nov 14 06:22 .
drwxr-xr-x 1 root root 4096 Nov 14 11:47 ..
-rw-r--r-- 1 root root   33 Nov 14 06:22 mission.txt
Codyssey Volume Persistence Test
Failed: False

15. Existing Containers Verification

> docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
NAMES                                 STATUS                     PORTS
codyssey-review-fix-20261114-165754   Up 4 hours                 127.0.0.1:53783->80/tcp
codyssey-review-20261114-165542       Created                    
codyssey-volume-2                     Exited (0) 5 hours ago     
codyssey-bind                         Up 5 hours                 127.0.0.1:30003->80/tcp
codyssey-web-2                        Up 6 hours                 127.0.0.1:30002->80/tcp
codyssey-web-1                        Up 6 hours                 127.0.0.1:30001->80/tcp
confident_pasteur                     Exited (137) 6 hours ago   
sharp_williamson                      Exited (0) 7 hours ago
Failed: False
````

---

## R06_git_project_paths.txt

````text
CODYSSEY MISSION REPORT SYSTEM
M_E1-1 R06 - Git and Project Paths
Date: 2026-11-14 20:49:32

01. Git Version

> git --version
git version 2.56.0.windows.4
Failed: False

02. Git User Name

> git config user.name
cody26jade
Failed: False

03. Git Repository Root

> git rev-parse --show-toplevel
C:/2026Codyssey_AllInOne/M_E1-1
Failed: False

04. Git Current Branch

> git branch --show-current
main
Failed: False

05. Git Remote Repository

> git remote -v
origin	https://github.com/cody26jade/M_E1-1.git (fetch)
origin	https://github.com/cody26jade/M_E1-1.git (push)
Failed: False

06. Git Commit History

> git log --oneline --graph -10
* a12b80f Complete M_E1-1 mission and reproduction verification
* 6947c22 Add Git commit evidence
* a3ad338 Initial commit: M_E1-1 mission
Failed: False

07. Git Working Tree

> git status --short --branch
## main...origin/main
?? logs/R02_linux_file_operations.txt
?? logs/R03_linux_permissions.txt
?? logs/R04_docker_basic_commands.txt
?? logs/R05_docker_advanced_verification.txt
?? scripts/
Failed: False

08. Project Directory Structure

> Get-ChildItem -Force |
        Select-Object Mode, Name |
        Format-Table -AutoSize

Mode   Name         
----   ----         
d--h-- .git         
d----- app          
d----- logs         
d----- screenshots  
d----- scripts      
-a---- .dockerignore
-a---- .gitignore   
-a---- Dockerfile   
-a---- README.md
Failed: False

09. Git Ignore Rules

> Get-Content ".\.gitignore"
# Environment and secrets
.env
.env.*
!.env.example
*.pem
*.key

# Python temporary files
__pycache__/
*.pyc
.venv/
venv/

# IDE settings
.vscode/
.idea/

# Windows temporary files
Thumbs.db
Desktop.ini
*.tmp
Failed: False

10. Docker Ignore Rules

> Get-Content ".\.dockerignore"
.git
screenshots
logs
Failed: False

11. Windows Absolute Path

> $absolutePath = "C:\2026Codyssey_AllInOne\M_E1-1\app\index.html"

    "ABSOLUTE PATH: $absolutePath"

    Get-Item -LiteralPath $absolutePath -ErrorAction Stop |
        Select-Object Name, Length, FullName |
        Format-List
ABSOLUTE PATH: C:\2026Codyssey_AllInOne\M_E1-1\app\index.html


Name     : index.html
Length   : 2430
FullName : C:\2026Codyssey_AllInOne\M_E1-1\app\index.html
Failed: False

12. Windows Relative Path

> $relativePath = ".\app\index.html"

    "CURRENT DIRECTORY: $((Get-Location).Path)"
    "RELATIVE PATH: $relativePath"

    Get-Item -LiteralPath $relativePath -ErrorAction Stop |
        Select-Object Name, Length, FullName |
        Format-List
CURRENT DIRECTORY: C:\2026Codyssey_AllInOne\M_E1-1
RELATIVE PATH: .\app\index.html


Name     : index.html
Length   : 2430
FullName : C:\2026Codyssey_AllInOne\M_E1-1\app\index.html
Failed: False

13. Absolute and Relative Path Comparison

> $absolutePath = "C:\2026Codyssey_AllInOne\M_E1-1\app\index.html"

    $relativePath = ".\app\index.html"

    $absoluteHash = Get-FileHash -LiteralPath $absolutePath -Algorithm SHA256 -ErrorAction Stop

    $relativeHash = Get-FileHash -LiteralPath $relativePath -Algorithm SHA256 -ErrorAction Stop

    "ABSOLUTE HASH: $($absoluteHash.Hash)"
    "RELATIVE HASH: $($relativeHash.Hash)"

    if ($absoluteHash.Hash -ne $relativeHash.Hash) {
        throw "File hash mismatch."
    }

    "PASS: Both paths identify identical file contents"
ABSOLUTE HASH: A15EBBC92FF67E7E524B2A54D79DC852C2477AE4635A0456BFDC847975407ED9
RELATIVE HASH: A15EBBC92FF67E7E524B2A54D79DC852C2477AE4635A0456BFDC847975407ED9
PASS: Both paths identify identical file contents
Failed: False

14. Linux Absolute and Relative Paths

> docker run --rm --pull=never ubuntu:latest bash -c 'exec 2>&1; set -ex; mkdir -p /tmp/codyssey-r06/app; echo "Linux Path Test" > /tmp/codyssey-r06/app/test.txt; cd /tmp/codyssey-r06; pwd; ls -l /tmp/codyssey-r06/app/test.txt; ls -l ./app/test.txt; cat /tmp/codyssey-r06/app/test.txt; cat ./app/test.txt; test /tmp/codyssey-r06/app/test.txt -ef ./app/test.txt; echo "PASS: Both Linux paths identify the same file"'
+ mkdir -p /tmp/codyssey-r06/app
+ echo Linux
Linux
Failed: False

15. Revision Evidence Files

> Get-ChildItem ".\logs" -Filter "R*.txt" -File |
        Select-Object Name, Length |
        Format-Table -AutoSize

    Get-ChildItem ".\scripts" -File |
        Select-Object Name, Length |
        Format-Table -AutoSize

Name                                 Length
----                                 ------
R02_linux_file_operations.txt          3922
R03_linux_permissions.txt              4693
R04_docker_basic_commands.txt          5845
R05_docker_advanced_verification.txt  14226



Name                         Length
----                         ------
R02_linux_file_operations.sh   1678
R03_linux_permissions.sh       2528
Failed: False
````

---

## R06B_linux_paths_verified.txt

````text
CODYSSEY MISSION REPORT SYSTEM
M_E1-1 R06B - Linux Path Verification
Date: 2026-11-14 20:51:40

01. Linux Path Script Verification

> Get-Item ".\scripts\R06_linux_paths.sh" -ErrorAction Stop |
        Select-Object Name, Length

Name               Length
----               ------
R06_linux_paths.sh   1434
Failed: False

02. Execute and Validate Linux Path Tests

> $scriptDir = (Resolve-Path ".\scripts").Path

    $result = docker run --rm --pull=never --mount "type=bind,source=$scriptDir,target=/scripts,readonly" ubuntu:latest bash /scripts/R06_linux_paths.sh 2>&1

    $exitCode = $LASTEXITCODE

    $result | ForEach-Object {
        $_.ToString()
    }

    if ($exitCode -ne 0) {
        throw "Docker execution failed: $exitCode"
    }

    $resultText = $result | Out-String

    if ($resultText -notmatch "(?m)^PASS: ALL LINUX PATH TESTS COMPLETED\s*$") {
        throw "Final success marker not found."
    }

    "PASS: Exit code and completion marker verified"
========================================
M_E1-1 R06 - Linux Path Verification
========================================

[01] Create test file
+ mkdir -p /tmp/codyssey-r06/app
+ echo 'Linux Path Test'
+ cd /tmp/codyssey-r06
+ pwd
/tmp/codyssey-r06
+ set +x

[02] Absolute path
+ ls -l /tmp/codyssey-r06/app/test.txt
-rw-r--r-- 1 root root 16 Nov 14 11:51 /tmp/codyssey-r06/app/test.txt
+ cat /tmp/codyssey-r06/app/test.txt
Linux Path Test
+ set +x

[03] Relative path
+ ls -l ./app/test.txt
-rw-r--r-- 1 root root 16 Nov 14 11:51 ./app/test.txt
+ cat ./app/test.txt
Linux Path Test
+ set +x

[04] Compare resolved paths
+ realpath /tmp/codyssey-r06/app/test.txt
/tmp/codyssey-r06/app/test.txt
+ realpath ./app/test.txt
/tmp/codyssey-r06/app/test.txt
+ set +x

[05] Compare file identity
+ test /tmp/codyssey-r06/app/test.txt -ef ./app/test.txt
+ set +x
PASS: Both Linux paths identify the same file

[06] Compare file hashes
+ sha256sum /tmp/codyssey-r06/app/test.txt
f37aef734b629ec780066d1289cba88cb7fdfcde8e780c8ca677cbdb874dd39d  /tmp/codyssey-r06/app/test.txt
+ sha256sum ./app/test.txt
f37aef734b629ec780066d1289cba88cb7fdfcde8e780c8ca677cbdb874dd39d  ./app/test.txt
+ set +x

[07] Parent directory relative path
+ cd app
+ pwd
/tmp/codyssey-r06/app
+ cat ../app/test.txt
Linux Path Test
+ test ../app/test.txt -ef ./test.txt
+ set +x
PASS: Parent directory path verified

[08] Cleanup
+ cd /tmp
+ rm /tmp/codyssey-r06/app/test.txt
+ rmdir /tmp/codyssey-r06/app
+ rmdir /tmp/codyssey-r06
+ test '!' -e /tmp/codyssey-r06
+ set +x

========================================
PASS: ALL LINUX PATH TESTS COMPLETED
========================================
PASS: Exit code and completion marker verified
Failed: False

03. Windows Path Comparison

> $absolutePath = (Resolve-Path ".\app\index.html").Path

    $relativePath = ".\app\index.html"

    "ABSOLUTE PATH: $absolutePath"
    "RELATIVE PATH: $relativePath"

    $hash1 = (Get-FileHash -LiteralPath $absolutePath -Algorithm SHA256 -ErrorAction Stop).Hash

    $hash2 = (Get-FileHash -LiteralPath $relativePath -Algorithm SHA256 -ErrorAction Stop).Hash

    "ABSOLUTE HASH: $hash1"
    "RELATIVE HASH: $hash2"

    if ($hash1 -ne $hash2) {
        throw "Windows file hash mismatch."
    }

    "PASS: Windows absolute and relative paths verified"
ABSOLUTE PATH: C:\2026Codyssey_AllInOne\M_E1-1\app\index.html
RELATIVE PATH: .\app\index.html
ABSOLUTE HASH: A15EBBC92FF67E7E524B2A54D79DC852C2477AE4635A0456BFDC847975407ED9
RELATIVE HASH: A15EBBC92FF67E7E524B2A54D79DC852C2477AE4635A0456BFDC847975407ED9
PASS: Windows absolute and relative paths verified
Failed: False

04. Existing Containers Verification

> docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
NAMES                                 STATUS                     PORTS
codyssey-review-fix-20261114-165754   Up 4 hours                 127.0.0.1:53783->80/tcp
codyssey-review-20261114-165542       Created                    
codyssey-volume-2                     Exited (0) 5 hours ago     
codyssey-bind                         Up 6 hours                 127.0.0.1:30003->80/tcp
codyssey-web-2                        Up 6 hours                 127.0.0.1:30002->80/tcp
codyssey-web-1                        Up 6 hours                 127.0.0.1:30001->80/tcp
confident_pasteur                     Exited (137) 6 hours ago   
sharp_williamson                      Exited (0) 7 hours ago
Failed: False
````

---

## R08_troubleshooting_verification.txt

````text
CODYSSEY MISSION REPORT SYSTEM
M_E1-1 R08 - Troubleshooting Verification
Date: 2026-11-14 20:55:44

01. Existing Port Usage

> docker ps --format "table {{.Names}}\t{{.Ports}}"

    if ($LASTEXITCODE -ne 0) {
        throw "Docker ps failed."
    }

    Get-NetTCPConnection -LocalPort 30003 -State Listen |
        Select-Object LocalAddress, LocalPort, State, OwningProcess |
        Format-Table -AutoSize
NAMES                                 PORTS
codyssey-review-fix-20261114-165754   127.0.0.1:53783->80/tcp
codyssey-bind                         127.0.0.1:30003->80/tcp
codyssey-web-2                        127.0.0.1:30002->80/tcp
codyssey-web-1                        127.0.0.1:30001->80/tcp

LocalAddress LocalPort  State OwningProcess
------------ ---------  ----- -------------
127.0.0.1        30003 Listen         27696
Failed: False

02. Identify Port Owner Process

> $connections = Get-NetTCPConnection -LocalPort 30003 -State Listen -ErrorAction Stop

    foreach ($connection in $connections) {

        Get-Process -Id $connection.OwningProcess -ErrorAction Stop |
            Select-Object Id, ProcessName |
            Format-Table -AutoSize
    }

   Id ProcessName       
   -- -----------       
27696 com.docker.backend
Failed: False

03. Reproduce and Resolve Port Conflict

> $testName = "codyssey-r08-" + [guid]::NewGuid().ToString("N").Substring(0,8)

    $created = $false

    try {

        "TEST CONTAINER: $testName"
        "EXPECTED RESULT: Port 30003 conflict"

        "COMMAND: docker run -d --name $testName -p 127.0.0.1:30003:80 codyssey-web:v1"

        $result = docker run -d --pull=never --name $testName -p 127.0.0.1:30003:80 codyssey-web:v1 2>&1

        $exitCode = $LASTEXITCODE

        $result | ForEach-Object { $_.ToString() }

        docker container inspect $testName 2>$null | Out-Null

        $created = ($LASTEXITCODE -eq 0)

        "EXPECTED FAILURE EXIT CODE: $exitCode"

        if ($exitCode -eq 0) {
            throw "Expected port conflict did not occur."
        }

        $resultText = $result | Out-String

        if ($resultText -notmatch "port is already allocated|address already in use|ports are not available") {
            throw "Failure was not identified as a port conflict."
        }

        "PASS: Port conflict reproduced"

        if ($created) {

            "COMMAND: docker rm $testName"

            docker rm $testName

            if ($LASTEXITCODE -ne 0) {
                throw "Test container removal failed."
            }

            $created = $false
        }

        "SOLUTION: Automatic host port allocation"

        "COMMAND: docker run -d --name $testName -p 127.0.0.1::80 codyssey-web:v1"

        docker run -d --pull=never --name $testName -p 127.0.0.1::80 codyssey-web:v1

        $runExit = $LASTEXITCODE

        docker container inspect $testName 2>$null | Out-Null

        $created = ($LASTEXITCODE -eq 0)

        if ($runExit -ne 0) {
            throw "Automatic port allocation failed."
        }

        "COMMAND: docker port $testName 80/tcp"

        $mapping = docker port $testName 80/tcp

        if ($LASTEXITCODE -ne 0) {
            throw "Port inspection failed."
        }

        $mapping

        if ($mapping -notmatch "127\.0\.0\.1:(\d+)") {
            throw "Assigned port not found."
        }

        $assignedPort = $Matches[1]

        $url = "http://127.0.0.1:$assignedPort/"

        "URL: $url"

        $response = $null

        for ($i = 0; $i -lt 10; $i++) {

            try {
                $response = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 5 -ErrorAction Stop
                break
            }
            catch {
                Start-Sleep -Seconds 1
            }
        }

        if (-not $response -or $response.StatusCode -ne 200) {
            throw "HTTP verification failed."
        }

        "HTTP STATUS: $($response.StatusCode)"

        "PASS: Port conflict resolved using automatic port allocation"
    }
    finally {

        if ($created) {

            "COMMAND: docker rm -f $testName"

            docker rm -f $testName

            if ($LASTEXITCODE -ne 0) {
                throw "Temporary container cleanup failed."
            }
        }
    }
TEST CONTAINER: codyssey-r08-c2554a2a
EXPECTED RESULT: Port 30003 conflict
COMMAND: docker run -d --name codyssey-r08-c2554a2a -p 127.0.0.1:30003:80 codyssey-web:v1
3af678a5ad4da6507d04aec49804acce77a84583effa40cc3e2cddda21bd58c0
docker: Error response from daemon: failed to set up container networking: driver failed programming external connectivity on endpoint codyssey-r08-c2554a2a (1e25393fa652569ea37effdaad4effe48a38e58d90348531b067d43c90e3b86c): Bind for 127.0.0.1:30003 failed: port is already allocated
System.Management.Automation.RemoteException
Run 'docker run --help' for more information
EXPECTED FAILURE EXIT CODE: 125
PASS: Port conflict reproduced
COMMAND: docker rm codyssey-r08-c2554a2a
codyssey-r08-c2554a2a
SOLUTION: Automatic host port allocation
COMMAND: docker run -d --name codyssey-r08-c2554a2a -p 127.0.0.1::80 codyssey-web:v1
9ffca275aa35c91d288b5081a18ba24425c244715f6c362fd07c22a3c59a8a04
COMMAND: docker port codyssey-r08-c2554a2a 80/tcp
127.0.0.1:52364
URL: http://127.0.0.1:52364/
HTTP STATUS: 200
PASS: Port conflict resolved using automatic port allocation
COMMAND: docker rm -f codyssey-r08-c2554a2a
codyssey-r08-c2554a2a
Failed: False

04. HTML Encoding Inspection

> $path = (Resolve-Path ".\app\index.html").Path

    $bytes = [System.IO.File]::ReadAllBytes($path)

    "FILE: app/index.html"

    "FILE SIZE: $($bytes.Length) bytes"

    "FIRST 8 BYTES: $([BitConverter]::ToString($bytes[0..7]))"

    $hasBom = (
        $bytes.Length -ge 3 -and
        $bytes[0] -eq 239 -and
        $bytes[1] -eq 187 -and
        $bytes[2] -eq 191
    )

    "UTF-8 BOM PRESENT: $hasBom"

    $strictUtf8 = New-Object System.Text.UTF8Encoding($false, $true)

    $decoded = $strictUtf8.GetString($bytes)

    "PASS: File is valid UTF-8"

    "FIRST LINE: $(($decoded -split '\r?\n')[0])"

    "CONSOLE OUTPUT ENCODING: $([Console]::OutputEncoding.WebName)"
FILE: app/index.html
FILE SIZE: 2430 bytes
FIRST 8 BYTES: EF-BB-BF-3C-21-44-4F-43
UTF-8 BOM PRESENT: True
PASS: File is valid UTF-8
FIRST LINE: ﻿<!DOCTYPE html>
CONSOLE OUTPUT ENCODING: ks_c_5601-1987
Failed: False

05. HTTP Download and SHA256 Verification

> $tempFile = Join-Path ([System.IO.Path]::GetTempPath()) ("codyssey-r08-" + [guid]::NewGuid().ToString("N") + ".html")

    try {

        "COMMAND: curl.exe --fail --silent --show-error --max-time 10 -o $tempFile http://127.0.0.1:30003/"

        curl.exe --fail --silent --show-error --max-time 10 -o $tempFile http://127.0.0.1:30003/

        if ($LASTEXITCODE -ne 0) {
            throw "HTTP download failed."
        }

        $sourceHash = (Get-FileHash ".\app\index.html" -Algorithm SHA256 -ErrorAction Stop).Hash

        $downloadHash = (Get-FileHash $tempFile -Algorithm SHA256 -ErrorAction Stop).Hash

        "SOURCE SHA256: $sourceHash"

        "DOWNLOAD SHA256: $downloadHash"

        if ($sourceHash -ne $downloadHash) {
            throw "Downloaded HTML differs from source."
        }

        "PASS: HTTP response matches original HTML bytes"
    }
    finally {

        if (Test-Path -LiteralPath $tempFile) {

            Remove-Item -LiteralPath $tempFile -Force -ErrorAction Stop
        }
    }
COMMAND: curl.exe --fail --silent --show-error --max-time 10 -o C:\Users\<USER>\AppData\Local\Temp\codyssey-r08-0b25b4970e2a4338b0a100872d8af250.html http://127.0.0.1:30003/
SOURCE SHA256: A15EBBC92FF67E7E524B2A54D79DC852C2477AE4635A0456BFDC847975407ED9
DOWNLOAD SHA256: A15EBBC92FF67E7E524B2A54D79DC852C2477AE4635A0456BFDC847975407ED9
PASS: HTTP response matches original HTML bytes
Failed: False

06. Existing Containers Verification

> docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
NAMES                                 STATUS                     PORTS
codyssey-review-fix-20261114-165754   Up 4 hours                 127.0.0.1:53783->80/tcp
codyssey-review-20261114-165542       Created                    
codyssey-volume-2                     Exited (0) 5 hours ago     
codyssey-bind                         Up 6 hours                 127.0.0.1:30003->80/tcp
codyssey-web-2                        Up 6 hours                 127.0.0.1:30002->80/tcp
codyssey-web-1                        Up 6 hours                 127.0.0.1:30001->80/tcp
confident_pasteur                     Exited (137) 7 hours ago   
sharp_williamson                      Exited (0) 7 hours ago
Failed: False

07. Existing Volume Verification

> docker volume ls
DRIVER    VOLUME NAME
local     codyssey-data
Failed: False
````

---

## R09_final_evidence_inventory.txt

````text
CODYSSEY MISSION REPORT SYSTEM
M_E1-1 R09 - Final Evidence Inventory
Date: 2026-11-14 20:57:47

01. Required Revision Logs

> $required = @(
        "logs/R02_linux_file_operations.txt",
        "logs/R03_linux_permissions.txt",
        "logs/R04_docker_basic_commands.txt",
        "logs/R05_docker_advanced_verification.txt",
        "logs/R06_git_project_paths.txt",
        "logs/R06B_linux_paths_verified.txt",
        "logs/R08_troubleshooting_verification.txt"
    )

    foreach ($file in $required) {

        $item = Get-Item -LiteralPath $file -ErrorAction Stop

        "PASS: $file | $($item.Length) bytes"
    }
PASS: logs/R02_linux_file_operations.txt | 3922 bytes
PASS: logs/R03_linux_permissions.txt | 4693 bytes
PASS: logs/R04_docker_basic_commands.txt | 5845 bytes
PASS: logs/R05_docker_advanced_verification.txt | 14226 bytes
PASS: logs/R06_git_project_paths.txt | 4868 bytes
PASS: logs/R06B_linux_paths_verified.txt | 4519 bytes
PASS: logs/R08_troubleshooting_verification.txt | 8840 bytes
Failed: False

02. Required Linux Scripts

> $required = @(
        "scripts/R02_linux_file_operations.sh",
        "scripts/R03_linux_permissions.sh",
        "scripts/R06_linux_paths.sh"
    )

    foreach ($file in $required) {

        $item = Get-Item -LiteralPath $file -ErrorAction Stop

        "PASS: $file | $($item.Length) bytes"
    }
PASS: scripts/R02_linux_file_operations.sh | 1678 bytes
PASS: scripts/R03_linux_permissions.sh | 2528 bytes
PASS: scripts/R06_linux_paths.sh | 1434 bytes
Failed: False

03. Git Identity Verification

> $name = git config user.name

    if ($LASTEXITCODE -ne 0 -or -not $name) {
        throw "Git user.name is not configured."
    }

    $email = git config user.email

    if ($LASTEXITCODE -ne 0 -or -not $email) {
        throw "Git user.email is not configured."
    }

    "GIT USER NAME: $name"
    "GIT USER EMAIL: Configured (value withheld)"
    "PASS: Git identity configured"
GIT USER NAME: cody26jade
GIT USER EMAIL: Configured (value withheld)
PASS: Git identity configured
Failed: False

04. Original Docker Build Command

> Select-String -Path ".\README.md" `
        -Pattern "docker build -t codyssey-web:v1" |
        Select-Object -First 1 -ExpandProperty Line

    Get-Content ".\Dockerfile"
docker build -t codyssey-web:v1 .
FROM nginx:alpine

COPY app/index.html /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
Failed: False

05. Screenshot Inventory

> $files = @(Get-ChildItem ".\screenshots" -File -Filter "*.png")

    "SCREENSHOT COUNT: $($files.Count)"

    $files |
        Select-Object Name |
        Format-Table -AutoSize
SCREENSHOT COUNT: 26

Name                           
----                           
01. Development Environment.png
02_linux_permission.png        
03_docker_basic.png            
04_docker_lifecycle.png        
05_docker_operation.png        
06_docker_build.png            
07_error_connection_refused.png
07_port_mapping.png            
07_web_browser.png             
08_bind_mount.png              
09_error_name_conflict.png     
09_error_resolved.png          
10-1_git_environment.png       
10-2_project_organization.png  
10-3_readme_creation.png       
10-4-2_github_remote.png       
10-4_git_initialization.png    
10-5-1_security_check.png      
10-5-2_readme_final.png        
10-5-3_git_commit(1).png       
10-5-3_git_commit(2).png       
10-5-4_github_public.png       
10-5-4_github_push.png         
10-6-1_reproduction_test.png   
10-6-1_review_browser.png      
10-6-2_readme_final.png
Failed: False

06. Log Inventory

> $files = @(Get-ChildItem ".\logs" -File)

    "LOG COUNT: $($files.Count)"

    $files |
        Select-Object Name, Length |
        Format-Table -AutoSize
LOG COUNT: 14

Name                                 Length
----                                 ------
01_docker_info.txt                     3696
05_docker_logs.txt                    19361
06_docker_build.txt                   11330
06_nginx_test.txt                      2464
07_port_mapping.txt                     434
08_bind_mount.txt                       180
09_volume.txt                           237
R02_linux_file_operations.txt          3922
R03_linux_permissions.txt              4693
R04_docker_basic_commands.txt          5845
R05_docker_advanced_verification.txt  14226
R06B_linux_paths_verified.txt          4519
R06_git_project_paths.txt              4868
R08_troubleshooting_verification.txt   8840
Failed: False

07. Git Working Tree

> git status --short --branch
## main...origin/main
?? logs/R02_linux_file_operations.txt
?? logs/R03_linux_permissions.txt
?? logs/R04_docker_basic_commands.txt
?? logs/R05_docker_advanced_verification.txt
?? logs/R06B_linux_paths_verified.txt
?? logs/R06_git_project_paths.txt
?? logs/R08_troubleshooting_verification.txt
?? scripts/
Failed: False
````
