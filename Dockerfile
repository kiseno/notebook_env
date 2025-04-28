# Python3.13 
# 公式：https://hub.docker.com/_/python
FROM python:3.13-slim-bookworm

# 作業ディレクトリの設定
WORKDIR /app

# pipxのインストール
RUN pip install --no-cache-dir pipx && \
    python3 -m pipx ensurepath && \
    export PATH=$PATH:/root/.local/bin

# 環境変数にpipxのインストールディレクトリを追加
ENV PATH="/root/.local/bin:$PATH"
    
# uvのインストール
RUN pipx install uv

# パッケージ管理
# uvの定義ファイルあるいは、requirements.txtをコピー
COPY pyproject.toml* requirements.txt* ./

# 定義ファイルのインストール どちらも存在する場合おかしくなるかも
RUN if [ -f pyproject.toml ]; then uv sync; fi
RUN if [ -f requirements.txt ]; then uv add -r requirements.txt; fi
