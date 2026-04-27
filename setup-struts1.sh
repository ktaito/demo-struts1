#!/bin/bash

# Struts1アプリケーション セットアップスクリプト
# Ubuntu/Debian用

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

# Step 1: Java 8のインストールとJAVA_HOME設定
print_info "Step 1: Java 8のインストールと環境設定..."

# Java 8がインストールされていなければインストール
if [ ! -d "/usr/lib/jvm/java-8-openjdk-amd64" ]; then
    print_info "Java 8をインストールします..."
    sudo apt-get update
    sudo apt-get install openjdk-8-jdk -y
    print_success "Java 8のインストールが完了しました"
else
    print_success "Java 8は既にインストールされています"
fi

# JAVA_HOMEをJava 8に設定（このスクリプト内で有効）
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
export PATH="$JAVA_HOME/bin:$PATH"

# システムのデフォルトJavaをJava 8に切り替え
sudo update-alternatives --set java "$JAVA_HOME/jre/bin/java" 2>/dev/null || \
    sudo update-alternatives --set java "$JAVA_HOME/bin/java" 2>/dev/null || true
sudo update-alternatives --set javac "$JAVA_HOME/bin/javac" 2>/dev/null || true

# JAVA_HOMEを.bashrcに永続化（既に設定済みなら上書き）
BASHRC="$HOME/.bashrc"
if grep -q "^export JAVA_HOME=" "$BASHRC" 2>/dev/null; then
    sed -i 's|^export JAVA_HOME=.*|export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64|' "$BASHRC"
    print_info "既存のJAVA_HOME設定をJava 8に更新しました（~/.bashrc）"
else
    echo '' >> "$BASHRC"
    echo '# Java 8 設定（setup-struts1.shにより追加）' >> "$BASHRC"
    echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' >> "$BASHRC"
    echo 'export PATH=$JAVA_HOME/bin:$PATH' >> "$BASHRC"
    print_info "JAVA_HOME設定を~/.bashrcに追加しました"
fi

print_info "JAVA_HOME=$JAVA_HOME"

# Javaバージョン確認（Java 8であることを検証）
JAVA_VER=$("$JAVA_HOME/bin/java" -version 2>&1 | head -n 1)
print_success "使用するJava: $JAVA_VER"
if echo "$JAVA_VER" | grep -q '"1\.8\.'; then
    print_success "Java 8が正しく設定されました"
else
    print_error "Java 8の設定に失敗しました: $JAVA_VER"
    exit 1
fi

# Step 2: Mavenのインストール
print_info "Step 2: Mavenのインストール確認..."
if command -v mvn &> /dev/null; then
    MVN_VERSION=$(mvn -version | head -n 1)
    print_success "Maven is already installed: $MVN_VERSION"
else
    print_info "Mavenがインストールされていません。インストールします..."
    sudo apt-get install maven -y
    print_success "Mavenのインストールが完了しました"
fi

# Mavenバージョン確認（Java 8を使用していることを確認）
mvn -version
print_info "MavenがJava 8を使用していることを確認してください（上記出力のJava version）"

# Step 3: MariaDBのインストールと起動
print_info "Step 3: MariaDBのセットアップ..."
if systemctl is-active --quiet mariadb; then
    print_success "MariaDBは既に起動しています"
else
    print_info "MariaDBをインストール・起動します..."
    sudo apt-get install mariadb-server -y
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
print_success "demo-struts1ディレクトリに移動しました"



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
if mysql -u root demo < demo.sql 2>/dev/null; then
    print_success "データベースのセットアップが完了しました"
else
    # Check if tables exist (might be already set up)
    if mysql -u root demo -e "SHOW TABLES;" | grep -q "task\|user"; then
        print_success "データベースは既にセットアップされています"
    else
        print_error "SQLファイルの実行に失敗しました"
        print_info "手動でSQLファイルを確認してください:"
        echo "  cat demo.sql"
        echo "  mysql -u root demo < demo.sql"
        exit 1
    fi
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
    print_info "Java 8が正しくインストールされているか確認してください:"
    echo "  java -version"
    echo "  mvn -version"
    exit 1
fi

# セットアップ完了メッセージ
echo ""
print_success "=== セットアップが完了しました！ ==="
echo ""
print_info "アプリケーションを起動するには以下のコマンドを実行してください:"
echo "  cd demo-struts1"
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
