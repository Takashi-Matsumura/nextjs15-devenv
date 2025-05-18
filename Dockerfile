FROM node:18-alpine

WORKDIR /app

# 依存関係をインストール
COPY package.json package-lock.json* ./
RUN npm install

# ソースコードはマウントするため、ここではコピーしない
# （ボリュームマウントでホットリロードを有効にするため）

EXPOSE 3000

# 開発サーバーを起動
CMD ["npm", "run", "dev"]
