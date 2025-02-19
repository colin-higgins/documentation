---
assets:
  dashboards: {}
  monitors: {}
  service_checks: assets/service_checks.json
categories:
  - data store
  - os & system
  - log collection
creates_events: false
ddtype: check
dependencies:
  - 'https://github.com/DataDog/integrations-core/blob/master/ceph/README.md'
display_name: Ceph
git_integration_title: ceph
guid: 8a60c34f-ecde-4269-bcae-636e6cbce98f
integration_id: ceph
integration_title: Ceph
is_public: true
kind: integration
maintainer: help@datadoghq.com
manifest_version: 1.0.0
metric_prefix: ceph.
metric_to_check: ceph.write_bytes_sec
name: ceph
process_signatures:
  - ceph-mon
  - ceph-mgr
  - ceph-osd
public_title: Datadog-Ceph インテグレーション
short_description: プールごとのパフォーマンスメトリクスを収集し、クラスター全体を監視 status.
support: コア
supported_os:
  - linux
  - mac_os
---
![Ceph ダッシュボード][1]

## 概要

Datadog-Ceph インテグレーションを有効にすると、以下のことができます。

  * ストレージプール全体のディスク使用状況を追跡できます。
  * 問題が発生した場合にサービスチェックを受信できます。
  * I/O パフォーマンスメトリクスを監視できます。

## セットアップ
### インストール

Ceph チェックは [Datadog Agent][3] パッケージに含まれています。Ceph サーバーに追加でインストールする必要はありません。

### コンフィグレーション

[Agent の構成ディレクトリ][4]のルートにある `conf.d/` フォルダーの `ceph.d/conf.yaml` ファイルを編集します。
使用可能なすべての構成オプションの詳細については、[サンプル ceph.d/conf.yaml][5] を参照してください。

```yaml
init_config:

instances:
  - ceph_cmd: /path/to/your/ceph # デフォルトは /usr/bin/ceph
    use_sudo: true               # ご利用のノードで ceph バイナリが sudo を必要とする場合のみ
```

`use_sudo` を有効にした場合は、`sudoers` ファイルに以下のような行を追加します。

```
dd-agent ALL=(ALL) NOPASSWD:/path/to/your/ceph
```

#### ログの収集

**Agent 6.0 以上で使用可能**

1. Datadog Agent で、ログの収集はデフォルトで無効になっています。以下のように、`datadog.yaml` ファイルでこれを有効にします。

    ```yaml
      logs_enabled: true
    ```

2. 次に、下部にある `logs` 行のコメントを解除して、`ceph.d/conf.yaml` を編集します。ログの `path` を Ceph ログファイルの正しいパスで更新してください。

    ```
      logs:
        - type: file
          path: /var/log/ceph/*.log
          source: ceph
          service: <APPLICATION_NAME>
    ```

3. [Agent を再起動します][10]。

### 検証

[Agent の status サブコマンドを実行][6]し、Checks セクションで `ceph` を探します。

## 収集データ
### メトリクス
{{< get-metrics-from-git "ceph" >}}


**注**: Ceph Luminous 以降を実行している場合、`ceph.osd.pct_used` メトリクスは表示されません。

### イベント
Ceph チェックには、イベントは含まれません。

### サービスのチェック

**ceph.overall_status**:<br>
Datadog Agent は、Ceph のホスト健全性チェックごとにサービスチェックを送信します。

Ceph Luminous 以降では、このサービスチェックのほかに、Ceph チェックはいくつかの健全性チェックも収集します。収集するチェックは構成可能で、デフォルトでは以下のとおりです。

**ceph.osd_down**:<br>
OSD がすべて動作中の場合は、`OK` を返します。それ以外の場合は、重大度が `HEALTH_WARN` なら `WARNING`、それ以外なら `CRITICAL` を返します。

**ceph.osd_orphan**:<br>
孤立 OSD がない場合は、`OK` を返します。それ以外の場合は、重大度が `HEALTH_WARN` なら `WARNING`、それ以外なら `CRITICAL` を返します。

**ceph.osd_full**:<br>
OSD がフルでない場合は、`OK` を返します。それ以外の場合は、重大度が `HEALTH_WARN` なら `WARNING`、それ以外なら `CRITICAL` を返します。

**ceph.osd_nearfull**:<br>
OSD がまったくフルでない場合は、`OK` を返します。それ以外の場合は、重大度が `HEALTH_WARN` なら `WARNING`、それ以外なら `CRITICAL` を返します。

**ceph.pool_full**:<br>
プールがクオータに達していない場合は、`OK` を返します。それ以外の場合は、重大度が `HEALTH_WARN` なら `WARNING`、それ以外なら `CRITICAL` を返します。

**ceph.pool_near_full**:<br>
クオータにまったく到達していない場合は、`OK` を返します。それ以外の場合は、重大度が `HEALTH_WARN` なら `WARNING`、それ以外なら `CRITICAL` を返します。

**ceph.pg_availability**:<br>
データ可用性が十分な場合は、`OK` を返します。それ以外の場合は、重大度が `HEALTH_WARN` なら `WARNING`、それ以外なら `CRITICAL` を返します。

**ceph.pg_degraded**:<br>
データ冗長性が十分な場合は、`OK` を返します。それ以外の場合は、重大度が `HEALTH_WARN` なら `WARNING`、それ以外なら `CRITICAL` を返します。

**ceph.pg_degraded_full**:<br>
クラスターにデータ冗長性の余裕が十分にある場合は、`OK` を返します。それ以外の場合は、重大度が `HEALTH_WARN` なら `WARNING`、それ以外なら `CRITICAL` を返します。

**ceph.pg_damaged**:<br>
データスクラビング後に矛盾がない場合は、`OK` を返します。それ以外の場合は、重大度が `HEALTH_WARN` なら `WARNING`、それ以外なら `CRITICAL` を返します。

**ceph.pg_not_scrubbed**:<br>
PG が最近スクラビングされた場合は、`OK` を返します。それ以外の場合は、重大度が `HEALTH_WARN` なら `WARNING`、それ以外なら `CRITICAL` を返します。

**ceph.pg_not_deep_scrubbed**:<br>
PG が最近ディープスクラビングされた場合は、`OK` を返します。それ以外の場合は、重大度が `HEALTH_WARN` なら `WARNING`、それ以外なら `CRITICAL` を返します。

**ceph.cache_pool_near_full**:<br>
キャッシュプールがまったくフルでない場合は、`OK` を返します。それ以外の場合は、重大度が `HEALTH_WARN` なら `WARNING`、それ以外なら `CRITICAL` を返します。

**ceph.too_few_pgs**:<br>
PG の数が最小しきい値を上回る場合は、`OK` を返します。それ以外の場合は、重大度が `HEALTH_WARN` なら `WARNING`、それ以外なら `CRITICAL` を返します。

**ceph.too_many_pgs**:<br>
PG の数が最大しきい値を下回る場合は、`OK` を返します。それ以外の場合は、重大度が `HEALTH_WARN` なら `WARNING`、それ以外なら `CRITICAL` を返します。

**ceph.object_unfound**:<br>
すべてのオブジェクトが見つかる場合は、`OK` を返します。それ以外の場合は、重大度が `HEALTH_WARN` なら `WARNING`、それ以外なら `CRITICAL` を返します。

**ceph.request_slow**:<br>
リクエストが通常の時間で処理されている場合は、`OK` を返します。それ以外の場合は、重大度が `HEALTH_WARN` なら `WARNING`、それ以外なら `CRITICAL` を返します。

**ceph.request_stuck**:<br>
リクエストが通常の時間で処理されている場合は、`OK` を返します。それ以外の場合は、重大度が `HEALTH_WARN` なら `WARNING`、それ以外なら `CRITICAL` を返します。

## トラブルシューティング
ご不明な点は、[Datadog のサポートチーム][8]までお問合せください。

## その他の参考資料

* [Ceph の監視: ノードステータスからクラスター全体のパフォーマンスまで][9]


[1]: https://raw.githubusercontent.com/DataDog/integrations-core/master/ceph/images/ceph_dashboard.png
[3]: https://app.datadoghq.com/account/settings#agent
[4]: https://docs.datadoghq.com/ja/agent/guide/agent-configuration-files/?tab=agentv6#agent-configuration-directory
[5]: https://github.com/DataDog/integrations-core/blob/master/ceph/datadog_checks/ceph/data/conf.yaml.example
[6]: https://docs.datadoghq.com/ja/agent/guide/agent-commands/?tab=agentv6#agent-status-and-information
[7]: https://github.com/DataDog/integrations-core/blob/master/ceph/metadata.csv
[8]: https://docs.datadoghq.com/ja/help
[9]: https://www.datadoghq.com/blog/monitor-ceph-datadog
[10]: https://docs.datadoghq.com/ja/agent/guide/agent-commands/?tab=agentv6#start-stop-and-restart-the-agent


{{< get-dependencies >}}