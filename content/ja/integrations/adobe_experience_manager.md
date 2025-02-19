---
title: Adobe Experience Manager
name: adobe_experience_manager
kind: インテグレーション
description: Adobe Experience Manager のログを収集して、エラー、リクエスト応答時間、パフォーマンスが低い Web ページなどを追跡します。
short_description: ログを収集して、エラー、リクエスト応答時間などを追跡
categories:
  - ログの収集
doc_link: /integrations/adobe_experience_manager/
aliases:
  - /ja/logs/log_collection/adobe_experience_manager
has_logo: true
integration_title: Adobe Experience Manager
is_public: true
public_title: Datadog-Adobe Experience Manager
supported_os:
  - linux
  - mac_os
  - windows
further_reading:
  - link: logs/
    tag: Documentation
    text: ログ管理
---
## 概要

Adobe Experience Manager のログを収集して、エラー、リクエスト応答時間、パフォーマンスが低い Web ページなどを追跡します。

## セットアップ
### インストール

Adobe Experience Manager が実行されているインスタンス上に [Agent をインストール][1]します。

####         - containerPort: 8126
          hostPort: 8126
          name: traceport
          protocol: TCP

**Agent バージョン 6.0 以上で使用可能**

* Datadog Agent で、ログの収集はデフォルトで無効になっています。以下のように、`datadog.yaml` ファイルでこれを有効にします。

```
logs_enabled: true
```

* ログの収集を開始するには、[conf.d ディレクトリ][2]に `adobe.experience.manager.d/conf.yaml` を作成し、以下の構成を追加します。

```
logs:
  - type: file
    path: cq-installation-dir/crx-quickstart/logs/*.log
    service: <MY_APPLICATION>
    source: adobe.experience.manager
```

* `path` パラメーターと `service` パラメーターの値を変更し、環境に合わせて構成してください。

* 最後に、[Agent を再起動][3]します。

## トラブルシューティング

ご不明な点は、[Datadog のサポートチーム][4]までお問合せください。

## その他の参考資料

{{< partial name="whats-next/whats-next.html" >}}

[1]: https://app.datadoghq.com/account/settings#agent
[2]: /ja/agent/guide/agent-configuration-files/?tab=agentv6#agent-configuration-directory
[3]: /ja/agent/guide/agent-commands/#restart-the-agent
[4]: /ja/help