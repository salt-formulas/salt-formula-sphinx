
===============================
Service Catalog
===============================

All used services within configured infrastructure.

{%- set services = {} %}
{%- for node_name, node_grains in salt['mine.get']('*', 'grains.items').iteritems() %}
{%- if node_grains.get('sphinx_doc', {}) != None %}
{%- set _dummy = services.update(node_grains.get('sphinx', {}).get('doc', {})) %}
{%- endif %}
{%- endfor %}

.. list-table::
   :widths: 20 80
   :header-rows: 1
   *  - **Service**
      - **Description**
{%- for service_name, service in services.iteritems() %}
   *  - {{ service.name }}
      - {{ service.get('description', '') }}
{%- endfor %}
