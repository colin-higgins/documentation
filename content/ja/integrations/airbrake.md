---
categories:
  - monitoring
  - exceptions
dependencies: []
description: イベントストリームで Airbrake 例外を表示、検索、議論
doc_link: 'https://docs.datadoghq.com/integrations/airbrake/'
git_integration_title: airbrake
has_logo: true
integration_title: Airbrake
is_public: true
kind: インテグレーション
manifest_version: '1.0'
name: airbrake
public_title: Datadog-Airbrake インテグレーション
short_description: イベントで Airbrake 例外を表示、検索、議論 stream.
version: '1.0'
---
{{< img src="integrations/airbrake/airbrakeevent.png" alt="airbrake event" responsive="true" popup="true">}}

## 概要

Airbrake を Datadog に接続すると、以下のことができます。

  * ストリームで例外をリアルタイムに確認できます。
  * グラフで例外を検索できます。
  * 例外についてチームで議論できます。

## セットアップ
### コンフィグレーション

Airbrake インテグレーションのセットアップには、Webhook を使用します。

1. Airbrake アカウントの Settings ページに移動します。

2. 有効にするプロジェクトごとに、"Integrations" をクリックします。

3. "WebHooks" をクリックして、"URL" フィールドに次の URL を入力します。

    ```
    https://app.datadoghq.com/intake/webhook/airbrake?api_key=<YOUR_DATADOG_API_KEY>
    ```

4. "Save" をクリックします。

## 収集データ

新しいエラーが発生するたびに、[イベントストリーム][1]に表示されます。

## トラブルシューティング
ご不明な点は、[Datadog のサポートチーム][2]までお問合せください。

[1]: https://docs.datadoghq.com/ja/graphing/event_stream
[2]: https://docs.datadoghq.com/ja/help


{{< get-dependencies >}}