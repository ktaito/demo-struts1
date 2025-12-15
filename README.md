# Struts1 Demo Application

Amazon Linux 2023用のStruts1デモアプリケーションです。

## 概要

- **フレームワーク**: Apache Struts 1.3.10
- **データベース**: MariaDB
- **ORM**: Hibernate 5.6.15
- **ビルドツール**: Maven
- **アプリケーションサーバー**: Jetty (開発用)

## 機能

- ユーザー認証（ログイン/ログアウト）
- Spotify楽曲データの表示・管理
- ページネーション機能
- Hibernate ORM によるデータベース操作

## セットアップ

### 前提条件

- Amazon Linux 2023
- Java 17
- Maven 3.6+
- MariaDB 10.5+

### 自動セットアップ

```bash
# リポジトリをクローン
git clone <repository-url>
cd <repository-name>

# セットアップスクリプトを実行
./setup-struts1.sh
```

### 手動セットアップ

詳細な手動セットアップ手順は [SETUP_GUIDE.md](SETUP_GUIDE.md) を参照してください。

## アプリケーションの起動

```bash
cd demo-struts1
mvn jetty:run
```

ブラウザで以下のURLにアクセス：
```
http://localhost:8081/demo-struts1/login.do
```

## テストユーザー

- **Username**: demo_test1
- **Password**: mypassword

## プロジェクト構成

```
.
├── demo-struts1/                 # メインアプリケーション
│   ├── src/main/java/           # Javaソースコード
│   ├── src/main/resources/      # 設定ファイル
│   ├── src/main/webapp/         # Webリソース
│   ├── pom.xml                  # Maven設定
│   └── demo.sql                 # データベース初期化スクリプト
├── setup-struts1.sh            # 自動セットアップスクリプト
├── SETUP_GUIDE.md              # セットアップガイド
└── README.md                   # このファイル
```

## トラブルシューティング

問題が発生した場合は [SETUP_GUIDE.md](SETUP_GUIDE.md) のトラブルシューティングセクションを参照してください。

## ライセンス

このプロジェクトはデモ・学習目的で作成されています。