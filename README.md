# Docker-TinyVideoServer
轻量级视频播放服务器

## 背景

收集了一些育儿视频，为了方便家人闲暇时间观看，想着是不是可以在家里的服务器上部署一个轻量级的视频服务器，理想的肯定是使用`docker`容器的方式，加上之前研究图床服务的时候就是使用的`Alpine`作为基础镜像，`nginx` + `php`，`supervisord`管理进程，**轻量级**视频服务器应该更简单。

## 步骤

1. 跳过在服务器安装Docker环境；

2. `clone` [Docker-TinyVideoServer](https://github.com/WenkaiZhou/Docker-TinyVideoServer) 仓库；

3. 构建镜像，版本可以随意；

        docker build -t video-server:1.0.0 .

4.  创建`video-server`容器，挂载路径这里使用工程的测试视频，真实的按照自己的设置：

        docker run -d \
            --name=video-server \
            --restart unless-stopped \
            -p 8099:80 \
            -v $(pwd)/test:/var/www/html \
            -e TZ="Asia/Shanghai" \
            video-server:1.0.0

5. 访问站点，`your_server_IP:8099/index.html`;