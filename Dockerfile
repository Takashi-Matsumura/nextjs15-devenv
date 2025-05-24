FROM node:18-slim

# Install OpenSSL (Prisma requires OpenSSL library at runtime)
RUN apt-get update \
    && apt-get install -y --no-install-recommends openssl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 依存関係をインストール
COPY package.json package-lock.json* ./
RUN npm install

# ソースコードはマウントするため、ここではコピーしない
# （ボリュームマウントでホットリロードを有効にするため）

EXPOSE 3000

# 開発サーバーを起動
CMD ["npm", "run", "dev"]
