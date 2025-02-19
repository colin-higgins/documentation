---
title: Using Graphs
kind: documentation
description: Visualize your data to gain insight
further_reading:
- link: "https://learn.datadoghq.com/course/view.php?id=8"
  tag: "Learning Center"
  text: "Building Better Dashboards"
---

## Overview

Whether you are using metrics, monitors, dashboards, notebooks, etc., all graphs in Datadog have the same basic functionality.

## Graphing editor

This page describes interacting with the graphic editor with the user interface. For advanced users, you can also create and edit graphs with JSON. To learn more about using JSON, see [Graphing with JSON][1].

On widgets, open the graphing editor by clicking on the pencil icon in the upper right corner. The graphing editor has the following tabs:

* **Share**: Embed the graph on any external web page.
* **JSON**: A more flexible editor, which requires knowledge of the graph definition language.
* **Edit**: The default UI tab for graphing options.

When you first open the graph editor, you are on the **Edit** tab. Here, you can use the UI to choose most settings. Here is an example:

{{< img src="graphing/using_graphs/references-graphing-edit-window-with-y.png" alt="Graphing Edit Tab" responsive="true" style="width:75%;" >}}

## Configuring a graph
To configure your graph on dashboards, follow this process:

1. [Select the visualization](#select-your-visualization)
2. [Choose the metric to graph](#choose-the-metric-to-graph)
3. [Filter](#filter)
4. [Aggregate and rollup](#aggregate-and-rollup)
5. [Apply additional functions](#advanced-graphing)
6. [Title the graph](#create-a-title)

### Select your visualization

Select your visualization from the available [widgets][2].

### Choose the metric to graph

Choose the metric to graph by searching or selecting it from the dropdown next to **Metric**. If you don't know which metric to use, start with the [Metrics Explorer][3] or a [notebook][4]. You can also see a list of metrics on the [Metrics Summary page][5].

### Filter

Your chosen metric can be filtered by host or tag using the **from** dropdown to the right of the metric. The default filter is *(everywhere)*. To learn more about tags, refer to the [Tagging][6] documentation.

### Aggregate and rollup
#### Aggregation method

Aggregation method is next to the filter dropdown. This defaults to `avg by` but you can change the method to `max by`, `min by`, or `sum by`. In most cases, the metric has many values for each time interval, coming from many hosts or instances. The aggregation method chosen determines how the metrics are aggregated into a single line.

#### Aggregation groups

Next to the aggregation method dropdown, choose what constitutes a line or grouping on a graph. For example, if you choose `host`, there is a line for every `host`. Each line is made up of the selected metric on a particular `host` aggregated using the chosen method.

#### Rollup to aggregate over time

Regardless of the options chosen above, there is always some aggregation of data due to the physical size constraints of the window holding the graph. If a metric is updated every second, and you are looking at 4 hours of data, you need 14,400 points to display everything. Each graph displayed has about 300 points shown at any given time. Therefore, each point displayed on the screen represents 48 data points.

In practice, metrics are collected by the Agent every 15-20 seconds. So one day's worth of data is 4,320 data points. If you display a day's worth of data on single graph, Datadog automatically rolls up the data. For more details, see the [Metrics Introduction][7].

To manually rollup the data, use the [rollup function][8]. Click the plus sign to the right of the aggregation group and choose `rollup` from the dropdown. Then choose how you want to aggregate the data and the interval in seconds.

This query creates a single line that represents the total available disk space, on average, across all machines rolled up in 60-second buckets:

{{< img src="graphing/using_graphs/references-graphing-rollup-example.png" alt="rollup example" responsive="true" style="width:90%;">}}

When switching to the JSON view, the query looks like this:

```
"q": "avg:system.disk.free{*}.rollup(avg, 60)"
```

For more about using the JSON view, see [Graphing with JSON][1].

### Advanced graphing

Depending on your analysis needs, you may choose to apply other mathematical functions to the query. Examples include rates and derivatives, smoothing, and others. See the [list of available functions][9].

Datadog also supports the ability to graph your metrics with various arithmetic operations. Use: `+`, `-`, `/`, and `*` to modify the values displayed on your graphs. This syntax allows for both integer values and arithmetic using multiple metrics.

#### Metric arithmetic using an integer

Modify the displayed value of a metric on a graph by performing an arithmetic operation. For example, to visualize the double of a specific metric, click the **Advanced...** link in the graph editor. Then enter your arithmetic in the `Formula` box, in this case: `a * 2`:

{{< img src="graphing/using_graphs/arithmetic_2.png" alt="Arithmetic 2" responsive="true" style="width:75%;" >}}

#### Arithmetic between two metrics

Visualize the percentage of a metric by dividing one metric over another, for example:
```
jvm.heap_memory / jvm.heap_memory_max
```

Use the **Advanced...** option in the graph editor and select **Add Query**. Each query is assigned a letter in alphabetical order: the first metric is represented by `a`, the second metric is represented by `b`, etc.

Then in the `Formula` box, enter the arithmetic (`a / b` for this example):

{{< img src="graphing/using_graphs/arithmetic_3.png" alt="Arithmetic 3" responsive="true" style="width:75%;" >}}

To display only the formula on your graph, click on the check marks next to the metrics `a` and `b`.

**Note**: Formulas are not lettered. Arithmetic cannot be done between formulas.

### Create a title

If you do nott enter a title, one is automatically generated based on your selections. However, it is recommended that you create a title that describes the purpose of the graph. 

### Save

Click **Done** to save your work and exit the editor. You can always come back to the editor to change the graph. If you make changes you don't want to save, click **Cancel**.

## Further Reading

{{< partial name="whats-next/whats-next.html" >}}

[1]: /graphing/graphing_json
[2]: /graphing/widgets
[3]: https://app.datadoghq.com/metric/explorer
[4]: https://app.datadoghq.com/notebook/list
[5]: https://app.datadoghq.com/metric/summary
[6]: /tagging
[7]: /graphing/metrics/introduction
[8]: /graphing/functions/rollup
[9]: /graphing/functions/#apply-functions-optional
