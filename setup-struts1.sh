#!/bin/bash

# Struts1アプリケーション セットアップスクリプト
# Amazon Linux 2023用

set -e  # エラーが発生したら停止

echo "=== Struts1アプリケーション セットアップ開始 ==="

# 色付きメッセージ用の関数
print_info() {
    echo -e "\033[34m[INFO]\033[0m $1"
}

print_success() {
    echo -e "\033[32m[SUCCESS]\033[0m $1"
}

print_error() {
    echo -e "\033[31m[ERROR]\033[0m $1"
}

print_warning() {
    echo -e "\033[33m[WARNING]\033[0m $1"
}

# Step 1: Javaのインストール確認とインストール
print_info "Step 1: Javaのインストール確認..."
if command -v java &> /dev/null; then
    JAVA_VERSION=$(java -version 2>&1 | head -n 1)
    print_success "Java is already installed: $JAVA_VERSION"
else
    print_info "Javaがインストールされていません。Java 17をインストールします..."
    sudo dnf install java-17-amazon-corretto-devel -y
    print_success "Java 17のインストールが完了しました"
fi

# Javaバージョン確認
java -version

# Step 2: Mavenのインストール
print_info "Step 2: Mavenのインストール確認..."
if command -v mvn &> /dev/null; then
    MVN_VERSION=$(mvn -version | head -n 1)
    print_success "Maven is already installed: $MVN_VERSION"
else
    print_info "Mavenがインストールされていません。インストールします..."
    sudo dnf install maven -y
    print_success "Mavenのインストールが完了しました"
fi

# Mavenバージョン確認
mvn -version

# Step 3: MariaDBのインストールと起動
print_info "Step 3: MariaDBのセットアップ..."
if systemctl is-active --quiet mariadb; then
    print_success "MariaDBは既に起動しています"
else
    print_info "MariaDBをインストール・起動します..."
    sudo dnf install mariadb105-server -y
    sudo systemctl start mariadb
    sudo systemctl enable mariadb
    print_success "MariaDBのインストール・起動が完了しました"
fi

# MariaDBのrootユーザー認証設定
print_info "MariaDBのrootユーザー認証を設定します..."
sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '';" 2>/dev/null || true
sudo mysql -u root -e "FLUSH PRIVILEGES;" 2>/dev/null || true
print_success "MariaDBの認証設定が完了しました"

# Step 4: プロジェクトディレクトリの確認
print_info "Step 4: プロジェクトディレクトリの確認..."
if [ ! -d "demo-struts1" ]; then
    print_error "demo-struts1ディレクトリが見つかりません"
    print_error "このスクリプトはdemo-struts1ディレクトリがある場所で実行してください"
    exit 1
fi

cd demo-struts1/demo-struts1
print_success "demo-struts1ディレクトリに移動しました



# Step 5: データベースのセットアップ
print_info "Step 5: データベースのセットアップ..."
if [ ! -f "demo.sql" ]; then
    print_error "demo.sqlファイルが見つかりません"
    exit 1
fi

# データベース作成
print_info "データベース 'demo' を作成します..."
mysql -u root -e "CREATE DATABASE IF NOT EXISTS demo;"



# SQLファイルの実行
print_info "SQLファイルを実行します..."
if mysql -u root demo < demo.sql; then
    print_success "データベースのセットアップが完了しました"
else
    print_error "SQLファイルの実行に失敗しました"
    print_info "手動でSQLファイルを確認してください:"
    echo "  cat demo.sql"
    echo "  mysql -u root demo < demo.sql"
    exit 1
fi

# Step 6: Hibernate設定の確認
print_info "Step 6: Hibernate設定の確認..."
HIBERNATE_CONFIG="src/main/resources/hibernate.cfg.xml"
if [ -f "$HIBERNATE_CONFIG" ]; then
    print_success "Hibernate設定ファイルが見つかりました: $HIBERNATE_CONFIG"
else
    print_warning "Hibernate設定ファイルが見つかりません: $HIBERNATE_CONFIG"
fi

# Step 7: アプリケーションのビルド
print_info "Step 7: アプリケーションのビルド..."

# pom.xmlとHibernate設定は既に修正済みと想定

# ビルド実行
mvn clean install -DskipTests
if [ $? -eq 0 ]; then
    print_success "ビルドが成功しました"
else
    print_error "ビルドに失敗しました"
    print_info "pom.xmlの設定を確認してください"
    print_info "Java 17が正しくインストールされているか確認してください:"
    echo "  java -version"
    echo "  mvn -version"
    exit 1
fi

# セットアップ完了メッセージ
echo ""
print_success "=== セットアップが完了しました！ ==="
echo ""
print_info "アプリケーションを起動するには以下のコマンドを実行してください:"
echo "  cd demo-struts1/demo-struts1"
echo "  mvn jetty:run"
echo ""
print_info "起動後、以下のURLでアクセスできます:"
echo "  http://localhost:8081/demo-struts1/login.do"
echo ""
print_info "テストユーザー:"
echo "  Username: demo_test1"
echo "  Password: mypassword"
echo ""
print_warning "注意: アプリケーションを停止するには Ctrl+C を押してください"
