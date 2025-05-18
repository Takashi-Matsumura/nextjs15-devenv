# Next.js & PostgreSQL 学習用テンプレート

このリポジトリは、Next.js と PostgreSQL (Prisma ORM) の組み合わせを学ぶための開発環境テンプレートです。

## 前提条件

- Node.js >= 18.x、npm
- Docker & Docker Compose

## セットアップ手順

1. リポジトリをクローンする
   ```bash
   git clone https://github.com/your-username/your-repo-name.git
   cd your-repo-name
   ```
2. 依存パッケージをインストールする
   ```bash
   npm install
   ```
3. 環境変数ファイルを作成する
   プロジェクトルートに `.env` ファイルを作成し、以下の内容を設定します:
   ```env
   DATABASE_URL="postgresql://postgres:postgres@localhost:5432/nextjs_db"
   ```
4. Docker Compose で PostgreSQL コンテナを起動する
   ```bash
   docker-compose up -d
   ```
5. Prisma Client を生成する
   ```bash
   npx prisma generate
   ```
6. 開発サーバーを起動する
   ```bash
   npm run dev
   ```

### Docker Compose を使って開発環境を一括起動する
ローカルに Node.js や PostgreSQL をインストールせずに、Docker コンテナ上で開発環境を立ち上げたい場合:
```bash
# コンテナのビルドと起動
docker-compose up -d --build

# Prisma の Client 生成（必要に応じて）
docker-compose exec nodejs-devenv npx prisma generate

# マイグレーション実行（必要に応じて）
docker-compose exec nodejs-devenv npx prisma migrate dev --name init
```
起動後、ブラウザで http://localhost:3000 を開いてアプリケーションが動いていることを確認してください。

ブラウザで http://localhost:3000 にアクセスして、アプリが起動していることを確認してください。

## その他

- マイグレーションを実行する場合:
  ```bash
  npx prisma migrate dev --name init
  ```
- アプリ内での Prisma Client の利用例:
  ```ts
  import { PrismaClient } from "@prisma/client";
  const prisma = new PrismaClient();
  ```
