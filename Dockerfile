# 定义构建参数，默认值为 latest
ARG OFFICIAL_TAG=latest
FROM sharelatex/sharelatex:${OFFICIAL_TAG}

# 再次声明 ARG 以便在 RUN 中使用 (Docker 的作用域规则)
ARG TL_MIRROR

# 更新并安装全量包
RUN tlmgr option repository ${TL_MIRROR} && \
    tlmgr update --self --all && \
    tlmgr install scheme-full && \
    tlmgr clean --all

# 验证 ctex 是否安装成功，这对中文论文至关重要
RUN kpsewhich ctexrep.cls