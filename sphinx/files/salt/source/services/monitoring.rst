
=====================
Monitoring Definition
=====================

Definition of monitoring metrics, logs, functional alarms.


Log Parsing Definitions
=======================


TODO: Include Heka log collector inputs


Metric Collection Definitions
=============================

TODO: Include collectd metric definitions


Functional Alarms Definitions
=============================

{%- if grains.get('prometheus') is mapping %}

.. list-table::
   :header-rows: 1

   *  - **Alarm**
      - **Description**
      - **Labels**
      - **Rule**
  {%- set alarms = {} %}
  {%- for node_name, node_grains in salt['mine.get']('*', 'grains.items')|dictsort %}
    {%- if node_grains.get('prometheus', {}).get('server', {}).get('alert', {}) is mapping %}
      {%- for alarm_name, alarm_def in node_grains.get('prometheus', {}).get('server', {}).get('alert', {})|dictsort %}
        {%- if not alarms.get(alarm_name) %}
          {%- do alarms.update({alarm_name: alarm_def}) %}
        {%- endif %}
      {%- endfor %}
    {%- endif %}
  {%- endfor %}

  {%- for name, alarm in alarms|dictsort %}
   *  - {{ name }}
      - {{ alarm.annotations.description }}
      - {%- for k,v in alarm.get('labels', {})|dictsort %} {{ k }} = {{ v }}{%- endfor %}
      - {{ alarm.if|replace("\n", "") }}
  {%- endfor %}
{%- else %}
**Node**
    Node where the alarm is defined

**Alarm**
    Alarm aggregating the triggers

**Trigger**
    Individual alarm trigger

**Metric**
    Metric being evaluated

**Operator**
    Conditional operator for the metric

**Threshold**
    The defined metric threshold

**Function**
    The aggregation functions for the given duration (avg, max, min, etc.)

**Duration**
    Duration for the aggregation

.. list-table::
   :header-rows: 1

   *  - **Node**
      - **Alarm**
      - **Trigger**
      - **Metric**
      - **Operator**
      - **Threshold**
      - **Function**
      - **Duration**
{%- for node_name, node_grains in salt['mine.get']('*', 'grains.items')|dictsort %}
{%- if node_grains.get('heka', {}).get('metric_collector', {}).get('alarm', {}) is mapping %}
{%- for alarm_name, alarm in node_grains.get('heka', {}).get('metric_collector', {}).get('alarm', {})|dictsort %}
{%- for trigger_name in alarm.triggers %}
{%- set trigger = node_grains.get('heka', {}).get('metric_collector', {}).get('trigger', {}).get(trigger_name, {  }) %}
{%- for rule in trigger.get('rules', []) %}
   *  - {{ node_name }}
      - {{ alarm_name }}
      - {{ trigger_name }}
      - {{ rule.metric }}
      - {{ rule.relational_operator }}
      - {{ rule.threshold }}
      - {{ rule.function }}
      - {{ rule.window }}
{%- endfor %}
{%- endfor %}
{%- endfor %}
{%- endif %}
{%- endfor %}
{%- endif %}
