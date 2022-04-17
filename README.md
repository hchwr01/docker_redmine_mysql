# docker_redmine_mysql

## Japanese followed by English

VSCodeでRubyのデバッグ開始実行後、Redmineにアクセスできるようになる。  
デバッグを終了させるとRedmineコンテナが再起動。

After running start debugging Ruby in VSCode, you will be able to access Redmine.
When you finish debugging, the Redmine container will be restarted.

## インストール手順
ダウンロードしたRedmineソースを docker_redmine_mysql/src に展開。
```
# docker-compose build
# docker-compose up -d
# docker-compose run --rm redmine rake db:create
# docker-compose run --rm redmine bin/bundle exec rake db:migrate
# docker-compose run --rm redmine bin/bundle exec rake redmine:load_default_data
```
エラーが出た場合はエラー内容に対応すること。

## 動作確認
`http://localhost:3000` 「応答なし」になると思うが、正常。

### VSCodeでRubyデバッグ設定
拡張機能インストール  
https://marketplace.visualstudio.com/items?itemName=rebornix.Ruby  

インストール後、launch.jsonを編集

```
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for rdebug-ide",
            "type": "Ruby",
            "request": "attach",
            "cwd": "${workspaceRoot}",
            "remoteHost": "0.0.0.0",
            "remotePort": "1234",
            "remoteWorkspaceRoot": "/redmine"
        }
    ]
}
```
「デバッグの開始」を実行すると
```
redmine_1     | Fast Debugger (ruby-debug-ide 0.7.3, debase 0.2.4.1, file filtering is supported) listens on 0.0.0.0:1234
redmine_1     | => Booting Puma
redmine_1     | => Rails 6.1.4.7 application starting in development 
redmine_1     | => Run `bin/rails server --help` for more startup options
redmine_1     | Puma starting in single mode...
redmine_1     | * Puma version: 5.6.4 (ruby 2.7.6-p219) ("Birdie's Version")
redmine_1     | *  Min threads: 0
redmine_1     | *  Max threads: 5
redmine_1     | *  Environment: development
redmine_1     | *          PID: 1
redmine_1     | * Listening on http://0.0.0.0:3000
redmine_1     | Use Ctrl-C to stop
```
となり、再度 http://localhost:3000 にアクセスすると Redmine の Welcomeページが表示される。

## Installation
Extract the downloaded Redmine source to docker_redmine_mysql/src.
```
# docker-compose build
# docker-compose up -d
# docker-compose run --rm redmine rake db:create
# docker-compose run --rm redmine bin/bundle exec rake db:migrate
# docker-compose run --rm redmine bin/bundle exec rake redmine:load_default_data
```
If an error occurs, the error content should be addressed.

## Confirmation of operation
`http://localhost:3000` would be unresponsive, but normal.

### Ruby debugging configuration in VSCode
Install Extension
https://marketplace.visualstudio.com/items?itemName=rebornix.Ruby  

Edit launch.json after installation
```
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for rdebug-ide",
            "type": "Ruby",
            "request": "attach",
            "cwd": "${workspaceRoot}",
            "remoteHost": "0.0.0.0",
            "remotePort": "1234",
            "remoteWorkspaceRoot": "/redmine"
        }
    ]
}
```

When you run "Start Debugging"
```
redmine_1     | Fast Debugger (ruby-debug-ide 0.7.3, debase 0.2.4.1, file filtering is supported) listens on 0.0.0.0:1234
redmine_1     | => Booting Puma
redmine_1     | => Rails 6.1.4.7 application starting in development 
redmine_1     | => Run `bin/rails server --help` for more startup options
redmine_1     | Puma starting in single mode...
redmine_1     | * Puma version: 5.6.4 (ruby 2.7.6-p219) ("Birdie's Version")
redmine_1     | *  Min threads: 0
redmine_1     | *  Max threads: 5
redmine_1     | *  Environment: development
redmine_1     | *          PID: 1
redmine_1     | * Listening on http://0.0.0.0:3000
redmine_1     | Use Ctrl-C to stop
```
and accessing http://localhost:3000 again will bring up the Redmine Welcome page.