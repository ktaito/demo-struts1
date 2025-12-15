# Struts1アプリケーション セットアップガイド

このガイドは、ワークショップ参加者がStruts1アプリケーションをローカル環境で動作させるための手順書です。

## 前提条件

- Amazon Linux 2023 / macOS / Windows
- インターネット接続
- 管理者権限

## 必要なソフトウェア

### 1. Java（JDK）
- **推奨バージョン**: Java 17
- **実績**: Java 17で動作確認済み

### 2. Maven
- **バージョン**: 3.6以上
- **用途**: ビルドツール

### 3. MariaDB/MySQL
- **バージョン**: MariaDB 10.5以上 または MySQL 8.0以上
- **用途**: データベース
- **注意**: Amazon LinuxではMariaDBが標準

---

## セットアップ手順（Amazon Linux 2023）

### Step 1: Javaのインストール確認

```bash
java -version
```

**既にインストールされている場合**: そのまま使用可能（Java 17推奨）

**インストールされていない場合**:
```bash
# Amazon Linux 2023でJava 17をインストール
sudo dnf install java-17-amazon-corretto-devel -y

# インストール確認
java -version
```

### Step 2: Mavenのインストール

```bash
# Amazon Linux 2023でMavenをインストール
sudo dnf install maven -y

# インストール確認
mvn -version
```

### Step 3: MariaDBのインストールと起動

```bash
# MariaDBインストール
sudo dnf install mariadb105-server -y

# MariaDB起動と自動起動設定
sudo systemctl start mariadb
sudo systemctl enable mariadb

# rootユーザーの認証設定（パスワードなし）
sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '';"
sudo mysql -u root -e "FLUSH PRIVILEGES;"
```

### Step 4: データベースのセットアップ

```bash
# プロジェクトディレクトリに移動
cd demo-struts1

# データベース作成とデータ投入
mysql -u root -e "CREATE DATABASE IF NOT EXISTS demo;"
mysql -u root demo < demo.sql
```

### Step 5: Hibernate設定の確認

`src/main/resources/hibernate.cfg.xml`を開き、MariaDBの接続情報を確認：

```xml
<property name="hibernate.connection.driver_class">org.mariadb.jdbc.Driver</property>
<property name="hibernate.connection.url">jdbc:mariadb://localhost:3306/demo</property>
<property name="hibernate.connection.username">root</property>
<property name="hibernate.connection.password"></property>  <!-- 空のパスワード -->
```

### Step 6: アプリケーションのビルド

```bash
# 依存関係の解決とビルド
mvn clean install -DskipTests
```

**ビルド成功の確認**: `BUILD SUCCESS`と表示されればOK

### Step 7: アプリケーションの起動

```bash
# Jettyサーバーで起動（ポート8081）
mvn jetty:run
```

**起動成功の確認**:
- `Started Jetty Server`と表示される
- `Started ServerConnector@...{0.0.0.0:8081}`と表示される

### Step 8: ブラウザでアクセス

ブラウザで以下のURLにアクセス：
```
http://localhost:8081/demo-struts1/login.do
```

**テストユーザーでログイン**:
- Username: `demo_test1`
- Password: `mypassword


## トラブルシューティング

### SQLファイルの構文エラーの場合
`demo.sql`実行時に構文エラーが発生した場合の修正方法：

**エラー例**:
```
ERROR 1064 (42000) at line 1: You have an error in your SQL syntax
```

**修正手順**:
1. `demo.sql`ファイルを開く
2. 以下の問題を確認・修正：

```sql
# 問題1: CREATE TABLE文の末尾にセミコロンがない
create table spotify_song (
    id BIGINT NOT NULL AUTO_INCREMENT,
    track_name VARCHAR(45) NOT NULL,
    artist_name VARCHAR(45) NOT NULL,
    genre VARCHAR(45) NOT NULL,
    popularity INT NOT NULL,
    PRIMARY KEY ( id )
)  -- ← ここにセミコロン（;）を追加

# 修正後:
);

# 問題2: データベース名の明示的指定
INSERT INTO demo.`user`  -- ← demo.を削除
# 修正後:
INSERT INTO `user`
```

**自動修正スクリプト**:
```bash
# バックアップ作成
cp demo.sql demo.sql.backup

# 自動修正
sed -i 's/INSERT INTO demo\./INSERT INTO /g' demo.sql
sed -i 's/CREATE TABLE \([^(]*\)/CREATE TABLE IF NOT EXISTS \1/g' demo.sql
sed -i '/CREATE TABLE.*{$/{ N; s/CREATE TABLE\([^;]*\)\n/CREATE TABLE\1;\n/ }' demo.sql

# 修正後に再実行
mysql -u root demo < demo.sql
```

### Maven WAR Plugin エラーの場合
**エラー例**:
```
Unable to load the mojo 'war' in the plugin 'org.apache.maven.plugins:maven-war-plugin:2.2'
API incompatibility: Cannot access defaults field of Properties
```

**原因**: 古いmaven-war-pluginがJava 17と互換性がない

**修正方法**:
1. `demo-struts1/pom.xml`の`<build><plugins>`セクションに以下を追加:

```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-war-plugin</artifactId>
    <version>3.4.0</version>
    <configuration>
        <failOnMissingWebXml>false</failOnMissingWebXml>
    </configuration>
</plugin>
```

2. 再ビルド実行:
```bash
mvn clean install -DskipTests
```

### テーブル既存エラーの場合
**エラー例**:
```
ERROR 1050 (42S01) at line 1: Table 'spotify_song' already exists
```

**原因**: データベースに既にテーブルが存在している

**修正方法**:
1. `demo.sql`ファイルを開く
2. `CREATE TABLE`文を`CREATE TABLE IF NOT EXISTS`に変更:

```sql
# 修正前:
CREATE TABLE spotify_song (

# 修正後:
CREATE TABLE IF NOT EXISTS spotify_song (
```

**または、既存データをクリアして再作成**:
```bash
# 既存データベースを削除して再作成
mysql -u root -e "DROP DATABASE IF EXISTS demo;"
mysql -u root -e "CREATE DATABASE demo;"
mysql -u root demo < demo.sql
```

### Hibernate接続エラーの場合
**エラー例**:
```
Access denied for user 'root'@'localhost' (using password: YES)
```

**原因**: Hibernate設定でパスワードが設定されているが、MariaDBのrootユーザーはパスワードなし

**修正方法**:
1. `src/main/resources/hibernate.cfg.xml`を開く
2. パスワード設定を空に変更:

```xml
<!-- 修正前 -->
<property name="hibernate.connection.password">password</property>

<!-- 修正後 -->
<property name="hibernate.connection.password"></property>
```

3. MariaDBドライバーに変更（推奨）:

```xml
<!-- 修正前 -->
<property name="hibernate.connection.driver_class">com.mysql.cj.jdbc.Driver</property>
<property name="hibernate.connection.url">jdbc:mysql://localhost:3306/demo</property>

<!-- 修正後 -->
<property name="hibernate.connection.driver_class">org.mariadb.jdbc.Driver</property>
<property name="hibernate.connection.url">jdbc:mariadb://localhost:3306/demo</property>
```

### MariaDB認証エラーの場合（Amazon Linux）
```bash
# rootユーザーの認証をリセット
sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '';"
sudo mysql -u root -e "FLUSH PRIVILEGES;"
```

### Mavenビルドエラーの場合
**エラー例**:
```
Source option 5 is no longer supported. Use 7 or later.
Target option 5 is no longer supported. Use 7 or later.
```

**原因**: pom.xmlにJavaバージョンが明示的に設定されていない

**修正方法**:
1. `demo-struts1/pom.xml`を開く
2. `<properties>`セクションを追加（`<packaging>war</packaging>`の後）:

```xml
<properties>
    <maven.compiler.source>17</maven.compiler.source>
    <maven.compiler.target>17</maven.compiler.target>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
</properties>
```

3. `<build>`セクション内にcompiler pluginを追加:

```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-compiler-plugin</artifactId>
    <version>3.11.0</version>
    <configuration>
        <source>17</source>
        <target>17</target>
        <encoding>UTF-8</encoding>
    </configuration>
</plugin>
```

4. WAR pluginも最新版に更新:

```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-war-plugin</artifactId>
    <version>3.4.0</version>
    <configuration>
        <failOnMissingWebXml>false</failOnMissingWebXml>
    </configuration>
</plugin>
```

5. 再ビルド実行:
```bash
mvn clean install -DskipTests
```

### ポート番号について
- **Amazon Linux**: デフォルトでポート8081を使用（pom.xmlで設定済み）