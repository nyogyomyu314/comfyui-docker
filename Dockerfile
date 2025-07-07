# 1. ベースイメージの選択
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

# 環境変数を設定
ENV DEBIAN_FRONTEND=noninteractive

# 2. 必要なライブラリやツールのインストール
RUN apt-get update && apt-get install -y \
  python3.10 \
  python3-pip \
  git \
  wget \
  ffmpeg \
  && rm -rf /var/lib/apt/lists/*

# コマンドをpythonに設定する
RUN ln -s /usr/bin/python3 /usr/bin/python

# 3. 作業ディレクトリの設定
WORKDIR /workspace

# 4. Pythonライブラリのインストール
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. ComfyUIのインストール

RUN comfy install

# 6. ポートの指定
EXPOSE 8188

# 7. コンテナ起動時のデフォルトコマンド
CMD ["comfy", "start", "--listen", "0.0.0.0"]