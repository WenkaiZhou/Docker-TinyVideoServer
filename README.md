# Docker-TinyVideoServer
轻量级视频播放服务器


## 步骤

1. 跳过在服务器安装Docker环境；

2. `clone` [Docker-TinyVideoServer](https://github.com/WenkaiZhou/Docker-TinyVideoServer) 仓库；

3. 构建镜像，版本可以随意；

        docker build -t video-server:1.5.1 .

4.  创建`video-server`容器：

        docker run -d \
            --name=video \
            --restart unless-stopped \
            -p 8099:80 \
            -v test/video:/var/www/html \
            -e TZ="Asia/Shanghai" \
            video-server:1.0.0

5. 访问站点，your_server_IP:8099/index.html