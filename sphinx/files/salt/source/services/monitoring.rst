
=====================
Monitoring Definition
=====================

Definition of monitoring metrics, logs, functional alarms.


Log Parsing Definitions
=======================

TODO: Include heka.log_collector inputs

Metric Collection Definitions
=============================

TODO: Include collectd metric defintions

Functional Alarms Definitions
=============================

.. list-table::
   :header-rows: 1

   *  - **Node**
      - **Alarm**
      - **Trigger**
      - **Operator**
      - **Threshold**
      - **Function**
      - **Window**
{%- for node_name, node_grains in salt['mine.get']('*', 'grains.items').iteritems() %}
{%- if node_grains.get('heka', {}).get('metric_collector', {}).get('alarm', {}) is mapping %}
{%- for alarm_name, alarm in node_grains.get('heka', {}).get('metric_collector', {}).get('alarm', {}).iteritems() %}
{%- for trigger_name in alarm.triggers %}
{%- set trigger = node_grains.get('heka', {}).get('metric_collector', {}).get('trigger', {}).get(trigger_name, {  }) %}
{%- for rule in trigger.get('rules', []) %}
   *  - {{ node_name }}
      - {{ alarm_name }}
      - {{ trigger_name }}
      - {{ rule.relational_operator }}
      - {{ rule.threshold }}
      - {{ rule.function }}
      - {{ rule.window }}
{%- endfor %}
{%- endfor %}
{%- endfor %}
{%- endif %}
{%- endfor %}
