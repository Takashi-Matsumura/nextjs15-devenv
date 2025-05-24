# Next.js & PostgreSQL 学習用テンプレート

このリポジトリは、Next.js と PostgreSQL (Prisma ORM) の組み合わせを学ぶための開発環境テンプレートです。

## 前提条件

- Node.js ≥ 18.x
- npm
- Docker & Docker Compose (Compose V2 以降推奨)

## セットアップ手順

1. **リポジトリをクローンする**

   ```bash
   git clone https://github.com/your-username/your-repo-name.git
   cd your-repo-name
   ```

2. **依存パッケージをインストールする**

   ```bash
   npm install
   ```

3. **環境変数ファイルを作成する**
   プロジェクトルートに `.env` を作成し、以下を設定します。

   ```env
   DATABASE_URL="postgresql://postgres:postgres@localhost:5432/nextjs_db"
   ```

4. **Docker Compose で PostgreSQL コンテナを起動する**

   ```bash
   docker compose up -d --build
   ```

5. **Prisma Client を生成する**

   ```bash
   npx prisma generate
   ```

6. **開発サーバーを起動する**

   ```bash
   npm run dev
   ```

### Docker Compose で開発環境を一括起動する

ローカルに Node.js や PostgreSQL をインストールせず、すべてコンテナで完結させたい場合:

```bash
# コンテナのビルドと起動
docker compose up -d --build

# Prisma Client 生成（必要に応じて）
docker compose exec nodejs-devenv npx prisma generate

# マイグレーション実行（必要に応じて）
docker compose exec nodejs-devenv npx prisma migrate dev --name init
```

起動後、ブラウザで [http://localhost:3000](http://localhost:3000) を開き、アプリケーションが動作していることを確認してください。

---

## トラブルシューティング

### macOS で外部デバイスから `http://<Mac-IP>:3000` に接続できない

Docker Desktop for macOS では、ポート公開が IPv6 のみで LISTEN し、IPv4 アドレス経由の接続が拒否されることがあります。以下の手順で **Wi‑Fi / iPhone USB インターフェースの IPv6 を無効化** すると解消します。

```bash
# Wi‑Fi を使用している場合
sudo networksetup -setv6off "Wi-Fi"

# iPhone の USB テザリングを使用している場合
sudo networksetup -setv6off "iPhone USB"

# その後 Docker Desktop をいったん Quit → 再起動
docker compose down   # 旧 CLI: docker-compose down
docker compose up -d  # 旧 CLI: docker-compose up -d
```

> **確認方法**
>
> ```bash
> netstat -anv | grep 3000
> ```
>
> `tcp46 *.3000 LISTEN` もしくは `TCP *:3000 (LISTEN)` が表示されていれば IPv4 でも待ち受けています。

#### 恒久的に対処したい場合

`/etc/sysctl.conf` に下記を追加し再起動することで、IPv6 ソケットが IPv4 マップドアドレスも受け付けるようになります。

```conf
net.inet6.ip6.v6only=0
```

---

## その他コマンド

| 目的                   | コマンド                             |
| ---------------------- | ------------------------------------ |
| マイグレーションを作成 | `npx prisma migrate dev --name init` |
| Prisma Client 再生成   | `npx prisma generate`                |

```ts
// Prisma Client の使用例
import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();
```

---

最終更新: 2025‑05‑21
