#!/bin/bash

# 1. 加载配置
if [ -f .env ]; then
    export $(cat .env | xargs)
else
    echo "错误: 找不到 .env 文件"
    exit 1
fi

echo ">>> 目标官方版本: $OFFICIAL_TAG"

# 2. 如果是 latest，尝试解析真实的语义化版本号
TARGET_TAG=$OFFICIAL_TAG
if [ "$OFFICIAL_TAG" = "latest" ]; then
    echo ">>> 正在检测官方 latest 对应的真实版本..."
    DIGEST=$(curl -s https://hub.docker.com/v2/repositories/sharelatex/sharelatex/tags/latest | jq -r '.digest')
    REAL_VER=$(curl -s "https://hub.docker.com/v2/repositories/sharelatex/sharelatex/tags/?page_size=100" | \
        jq -r ".results[] | select(.digest == \"$DIGEST\" and .name != \"latest\") | .name" | \
        sort -V | tail -n 1)
    if [ ! -z "$REAL_VER" ]; then
        TARGET_TAG=$REAL_VER
        echo ">>> 检测到真实版本为: $TARGET_TAG"
    fi
fi

# 3. 构建镜像
# 我们同时给镜像打两个标签：具体版本号 和 latest
docker build \
    --build-arg OFFICIAL_TAG=$OFFICIAL_TAG \
    --build-arg TL_MIRROR=$TL_MIRROR \
    -t ${MY_REPO}:${TARGET_TAG} \
    -t ${MY_REPO}:latest .

# 4. 推送
if [ $? -eq 0 ]; then
    echo ">>> 构建成功，准备推送..."
    docker push ${MY_REPO}:${TARGET_TAG}
    docker push ${MY_REPO}:latest
    echo ">>> 所有任务完成！"
    echo ">>> 你的镜像地址: ${MY_REPO}:${TARGET_TAG}"
else
    echo ">>> 构建失败，请检查网络或磁盘。"
fi