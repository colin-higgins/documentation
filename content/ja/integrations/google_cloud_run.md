---
categories:
  - クラウド
  - オーケストレーション
  - google cloud
  - ログの収集
ddtype: クローラー
dependencies: []
description: クラスターからメトリクス、トレース、ログを収集し、Datadog で分析
doc_link: 'https://docs.datadoghq.com/integrations/google_cloud_run/'
further_reading:
  - link: 'https://www.datadoghq.com/blog/monitor-google-cloud-run-with-datadog/'
    tag: ブログ
    text: Datadog を使用した Google Cloud Run の監視
git_integration_title: google_cloud_run
has_logo: true
integration_title: Google Cloud Run
is_public: true
kind: インテグレーション
manifest_version: 1
name: google_cloud_run
public_title: Datadog-Google Cloud Run インテグレーション
short_description: クラスターからメトリクス、トレース、ログを収集し、Datadog で分析
version: 1
---
## 概要

Cloud Run は、HTTP リクエストによって呼び出し可能なステートレスコンテナを実行できるマネージド型のコンピューティングプラットフォームです。

このインテグレーションを有効にすると、Cloud Run のメトリクス、トレース、ログのすべてを Datadog に表示できます。

## セットアップ
### メトリクスの収集
#### インストール

Cloud Run のフルマネージド版を使用する場合は、[Google Cloud Platform インテグレーション][1]をセットアップするだけです。

GKE 上で Cloud Run をセットアップする場合は、[Google Cloud Platform インテグレーション][1]を有効にした後、[Kubernetes DaemonSet セットアップ][2]を使用してクラスター内に Datadog Agent をデプロイします。

**注**: Datadog Agent DaemonSet をデプロイする際は、必ず、ポッド仕様内で `hostNetwork: true` を設定してください。

### ログの収集

Google Cloud Run は、[監査ログ][3]も公開します。
Google Cloud Run のログは、Stackdriver を使用して収集され、HTTP プッシュフォワーダーを使用して Cloud Pub/Sub へ送信されます。Cloud Pub/Sub をまだセットアップしていない場合は、[HTTP プッシュフォワーダーを使用してセットアップ][4]してください。

これが完了したら、Google Cloud Run のログを Stackdriver から Pub/Sub へエクスポートします。

1. [Stackdriver のページ][5]に移動し、Google Cloud Run のログを絞り込みます。
2. **エクスポートを作成**をクリックし、シンクに適宜名前を付けます。
3. エクスポート先として「Cloud Pub/Sub」を選択し、エクスポート用に作成された Pub/Sub を選択します。**注**: この Pub/Sub は別のプロジェクトに置くこともできます。

{{< img src="integrations/google_cloud_run/export_cloud_run_revision.png" alt="Export Google Cloud Run Logs to Pub Sub" responsive="true">}}

4. **作成**をクリックし、確認メッセージが表示されるまで待ちます。

## 収集データ
### メトリクス
{{< get-metrics-from-git "google_cloud_run" >}}


### イベント
Google Cloud Functions インテグレーションには、イベントは含まれません。

### サービスのチェック
Google Cloud Functions インテグレーションには、サービスのチェック機能は含まれません。

## トラブルシューティング
ご不明な点は、[Datadog のサポートチーム][7]までお問合せください。

## その他の参考資料

{{< partial name="whats-next/whats-next.html" >}}

[1]: https://docs.datadoghq.com/ja/integrations/google_cloud_platform
[2]: https://docs.datadoghq.com/ja/agent/kubernetes/daemonset_setup
[3]: https://cloud.google.com/run/docs/audit-logging
[4]: https://docs.datadoghq.com/ja/integrations/google_cloud_platform/#log-collection
[5]: https://console.cloud.google.com/logs/viewer
[6]: https://github.com/DataDog/dogweb/blob/prod/integration/google_cloud_run/google_cloud_run_metadata.csv
[7]: https://docs.datadoghq.com/ja/help


{{< get-dependencies >}}