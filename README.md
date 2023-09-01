## 👋 Welcome to jekyll 🚀  

jekyll README  
  
  
## Install my system scripts  

```shell
 sudo bash -c "$(curl -q -LSsf "https://github.com/systemmgr/installer/raw/main/install.sh")"
 sudo systemmgr --config && sudo systemmgr install scripts  
```
  
## Automatic install/update  
  
```shell
dockermgr update jekyll
```
  
## Install and run container
  
```shell
mkdir -p "$HOME/.local/share/srv/docker/jekyll/rootfs"
git clone "https://github.com/dockermgr/jekyll" "$HOME/.local/share/CasjaysDev/dockermgr/jekyll"
cp -Rfva "$HOME/.local/share/CasjaysDev/dockermgr/jekyll/rootfs/." "$HOME/.local/share/srv/docker/jekyll/rootfs/"
docker run -d \
--restart always \
--privileged \
--name casjaysdevdocker-jekyll \
--hostname jekyll \
-e TZ=${TIMEZONE:-America/New_York} \
-v "$HOME/.local/share/srv/docker/casjaysdevdocker-jekyll/rootfs/data:/data:z" \
-v "$HOME/.local/share/srv/docker/casjaysdevdocker-jekyll/rootfs/config:/config:z" \
-p 80:80 \
casjaysdevdocker/jekyll:latest
```
  
## via docker-compose  
  
```yaml
version: "2"
services:
  ProjectName:
    image: casjaysdevdocker/jekyll
    container_name: casjaysdevdocker-jekyll
    environment:
      - TZ=America/New_York
      - HOSTNAME=jekyll
    volumes:
      - "$HOME/.local/share/srv/docker/casjaysdevdocker-jekyll/rootfs/data:/data:z"
      - "$HOME/.local/share/srv/docker/casjaysdevdocker-jekyll/rootfs/config:/config:z"
    ports:
      - 80:80
    restart: always
```
  
## Get source files  
  
```shell
dockermgr download src casjaysdevdocker/jekyll
```
  
OR
  
```shell
git clone "https://github.com/casjaysdevdocker/jekyll" "$HOME/Projects/github/casjaysdevdocker/jekyll"
```
  
## Build container  
  
```shell
cd "$HOME/Projects/github/casjaysdevdocker/jekyll"
buildx 
```
  
## Authors  
  
🤖 casjay: [Github](https://github.com/casjay) 🤖  
⛵ casjaysdevdocker: [Github](https://github.com/casjaysdevdocker) [Docker](https://hub.docker.com/u/casjaysdevdocker) ⛵  
