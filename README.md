# FjordContributions

[![HTML](https://img.shields.io/badge/HTML-%23E34F26.svg?logo=html5&logoColor=white)](#)
[![Rails](https://img.shields.io/badge/Rails-%23CC0000.svg?logo=ruby-on-rails&logoColor=white)](#)
[![Postgres](https://img.shields.io/badge/Postgres-%23316192.svg?logo=postgresql&logoColor=white)](#)
[![TailwindCSS](https://img.shields.io/badge/Tailwind%20CSS-%2338B2AC.svg?logo=tailwind-css&logoColor=white)](#)
[![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?logo=github-actions&logoColor=white)](https://github.com/ymmtd0x0b/FjordContributions/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

プログラミングスクール・フィヨルドブートキャンプのチーム開発プラクティスにて、受講生が関わった Issue や PullRequest 、Wiki を個人に焦点を当てて可視化できるサービスです。

GitHub の検索フォームに手入力して探しださずとも自動でデータを取得し、一覧表示できます。また、共有用 URL によって本サービスに登録していない人にも一覧表示を共有することも可能です。

<br />

<p align="center">
  <kbd><img src="https://github.com/user-attachments/assets/fc27537d-8c3a-4c77-a22c-44673cc5b8aa" width="700" /></kbd>
</p>

<br />
<br />

## URL

https://fjordcontributions.onrender.com

<br />

## インストールと起動

```
$ git clone https://github.com/ymmtd0x0b/FjordContributions.git
$ cd FjordContributions
```

### 起動準備

本プロジェクトではアカウント登録・ログイン機能に [OmniAuth](https://github.com/omniauth/omniauth) による GitHub 認証を、GitHub 上のデータの取得に [Octokit](https://github.com/octokit/octokit.rb) を使用しています。

起動する前に以下の設定を行ってください。


### 環境変数の設定

OmniAuth、Octokit の双方は環境変数を通して取得した機密情報 (以降で設定します) を基に動作します。

本プロジェクトでは [dotenv](https://github.com/bkeepers/dotenv) を導入しているため `.evnファイル` を作成することで、お使いのシステムに手を加えること無く環境変数を設定可能です。

- .envファイルの作成<div>

```
$ touch .env
```

</div>

### OmniAuth の準備

OmniAuth の動作に必要な設定に関しては [OAuthの設定](https://github.com/ymmtd0x0b/FjordContributions/wiki/OAuth-%E3%81%AE%E8%A8%AD%E5%AE%9A) を参照してください。

### Octokit の準備

Octokit の動作に必要な設定に関しては [Personal access token の設定](https://github.com/ymmtd0x0b/FjordContributions/wiki/Personal-access-token-%E3%81%AE%E8%A8%AD%E5%AE%9A) を参照してください。

### その他

機密情報とは別にプロジェクトの動作に必要な環境変数を追記します。


```
# .env
...
BOOTCAMP_REPOSITORY_ID = '5139175'
GITHUB_URL = 'https://github.com'
```

### セットアップ

ここまでの準備に問題がなければ、次のコマンドでセットアップが正常に動作します。

```
$ bin/setup
```


### 起動

```
$ bin/dev
```

起動後は [http://localhost:3000/](http://localhost:3000/) にアクセスしてください。

<br />

## テスト

#### ヘッドレスブラウザによるテスト

```
$ bin/rspec
```


#### 通常のブラウザによるテスト

```
$ HEADFULL=1 bin/rspec
```

<br />

## Lint

次のコマンドで以下の lint をまとめて実行できます。

```
$ bin/lint
```

- Ruby
  - rubocop
  - slimlint

- JavaScript
  - eslint
  - prettier

また、JavaScript の警告は次のコマンドで自動修正可能です。

```
$ npm run format
```

<br />

## 使用技術

- Ruby 3.3.4
- Ruby and Rails 7.2.1
- PostgreSQL
- Hotwire
  - turbo-rails 2.0.7
  - stimulus-rails 1.3.4
- Slim 5.2.1
- TailwindCSS
  - tailwindcss-rails 2.7.4
- Node.js 20.12.2
- Octokit 9.1.0
- Git 2.3.0


#### ログイン機能

- OmniAuth
  - omniauth-github 2.0.1
  - omniauth-rails_csrf_protection 1.0.2


#### テスティングフレームワーク

- RSpec
  - rspec-rails 7.0.1
  - factory_bot 6.4.6


#### 計測ツール

- SimpleCov 0.22.0


#### Linter/Formatter

- RuboCop 1.66.1
- Slim-Lint 0.29.0
- ESLint 3.1.0
- Prettier 3.3.3


#### CI/CD

- GitHub Actions


#### インフラ

- Render.com
- Supabase
